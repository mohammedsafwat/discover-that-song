//
//  AuthorizationDataRepository.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-24.
//

import Combine
import Foundation

struct AuthorizationDataRepository: AuthorizationDataSource {

    // MARK: - Properties

    private let authorizationRemoteDataSource: AuthorizationDataSource

    // MARK: - Initializer

    init(authorizationRemoteDataSource: AuthorizationDataSource) {
        self.authorizationRemoteDataSource = authorizationRemoteDataSource
    }

    // MARK: - AuthorizationDataSource

    func accessToken() -> AnyPublisher<Token, Error> {
        authorizationRemoteDataSource.accessToken()
    }
}
