//
//  RestNetworkClient.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

import Alamofire
import Combine
import Foundation

final class RestNetworkClient: RestNetworkClientProtocol {

    // MARK: - Properties

    var headers: [String: String] = [:]
    private var cancellable: Cancellable?

    // MARK: - Deinit

    deinit {
        cancellable?.cancel()
    }

    // MARK: - RestNetworkClientProtocol

    func performRequest<T: Decodable>(
        url: URL,
        type: RequestType,
        parameters: [String: Any]
    ) -> AnyPublisher<T, Error> {
        var publisher: AnyPublisher<T, Error> {
            subject.eraseToAnyPublisher()
        }
        let subject = PassthroughSubject<T, Error>()

        let method: HTTPMethod = type == .GET ? .get : .post
        let headers = HTTPHeaders(self.headers.compactMap { HTTPHeader(name: $0, value: $1) })

        if cancellable != nil {
            cancellable?.cancel()
        }

        cancellable = AF.request(
            url,
            method: method,
            parameters: parameters,
            headers: headers
        ).publishDecodable(type: T.self).sink { completion in
            switch completion {
            case .failure(let error):
                let statusCode = error.asAFError?.responseCode ?? -1
                let message = error.localizedDescription
                let dataError = DataError(statusCode: statusCode, message: message)
                subject.send(completion: .failure(dataError))
            case .finished:
                subject.send(completion: .finished)
            }
        } receiveValue: { result in
            guard let value = result.value else {
                subject.send(completion: .failure(DataError(type: .parse)))
                return
            }
            subject.send(value)
        }
        return publisher
    }
}
