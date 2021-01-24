//
//  AuthorizationDataModule.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-24.
//

import Foundation

struct AuthorizationDataModule {

    // MARK: - Properties

    static let shared = AuthorizationDataModule()

    // MARK: - Initializer

    private init() {}

    // MARK: - Authorization Data Source Method

    func authorizationRemoteDataSource(networkClient: RestNetworkClientProtocol) -> AuthorizationDataSource {
        return AuthorizationRemoteDataSource(networkClient: networkClient)
    }
}
