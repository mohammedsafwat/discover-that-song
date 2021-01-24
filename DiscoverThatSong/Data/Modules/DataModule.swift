//
//  DataModule.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Foundation

class DataModule {

    // MARK: - Properties

    static let shared = DataModule()
    private var restNetworkClient = HttpClientModule.shared.httpClient

    // MARK: - Repositories Methods

    func tracksRepository() -> TracksDataSource {
        let tracksRemoteDataSource = TracksDataModule.shared.tracksRemoteDataSource(networkClient: restNetworkClient)
        return TracksDataRepository(tracksRemoteDataSource: tracksRemoteDataSource)
    }

    var authroizationRepository: AuthorizationDataSource {
        let authorizationRemoteDataSource = AuthorizationDataModule.shared.authorizationRemoteDataSource(
            networkClient: restNetworkClient
        )
        return AuthorizationDataRepository(authorizationRemoteDataSource: authorizationRemoteDataSource)
    }
}
