//
//  AuthorizationRemoteDataSource.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-24.
//

import Combine
import Foundation

class AuthorizationRemoteDataSource: AuthorizationDataSource {
    // MARK: - Properties
    private var networkClient: RestNetworkClientProtocol

    // MARK: - Initializer

    init(networkClient: RestNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    // MARK: - AuthorizationDataSource

    func accessToken() -> AnyPublisher<Token, Error> {
        let subject = PassthroughSubject<Token, Error>()
        var publisher: AnyPublisher<Token, Error> {
            subject.eraseToAnyPublisher()
        }

        guard let url = URL(string: API.Authorization.EndpointURL) else {
            subject.send(completion: .failure(DataError(type: .requestFailed)))
            return publisher
        }

        let parameters = API.Authorization.Parameters
        networkClient.headers = API.Authorization.Header
        return networkClient.performRequest(url: url, type: .POST, parameters: parameters)
    }
}
