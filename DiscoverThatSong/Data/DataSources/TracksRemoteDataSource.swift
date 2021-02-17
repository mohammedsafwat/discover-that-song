//
//  TracksRemoteDataSource.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Combine
import Foundation

class TracksRemoteDataSource: TracksDataSource {

    // MARK: - Initializer

    init(networkClient: RestNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    // MARK: - Deinitializer

    deinit {
        cancellable?.cancel()
    }

    // MARK: - TracksDataSource

    var authorizationDataSource: AuthorizationDataSource {
        DataModule.shared.authroizationRepository
    }

    func tracks(ids: String) -> AnyPublisher<Tracks, Error> {
        let subject = PassthroughSubject<Tracks, Error>()
        var publisher: AnyPublisher<Tracks, Error> {
            subject.eraseToAnyPublisher()
        }

        if cancellable != nil {
            cancellable?.cancel()
        }
        
        cancellable = authorizationDataSource.accessToken().flatMap { [unowned self] token -> AnyPublisher<Tracks, Error> in
            guard let url = URL(string: API.Tracks.EndpointURL) else {
                subject.send(completion: .failure(DataError(type: .requestFailed)))
                return publisher
            }
            let parameters = ["ids": ids]
            self.networkClient.headers = [API.Authorization.HeaderKey: token.bearerToken]
            return self.networkClient.performRequest(url: url, type: .GET, parameters: parameters)
        }.sink { completion in
            subject.send(completion: completion)
        } receiveValue: { tracks in
            subject.send(tracks)
        }

        return publisher
    }

    // MARK: - Private

    private var networkClient: RestNetworkClientProtocol
    private var cancellable: AnyCancellable?

    private func tracks(url: URL, type: RequestType, parameters: [String: String]) -> AnyPublisher<Tracks, Error> {
        return networkClient.performRequest(url: url, type: .GET, parameters: parameters)
    }
}
