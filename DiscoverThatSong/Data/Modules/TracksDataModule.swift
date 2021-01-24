//
//  TracksDataModule.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Foundation

struct TracksDataModule {

    // MARK: - Properties
    
    static let shared = TracksDataModule()

    // MARK: - Initializer
    
    private init() {}

    // MARK: - Tracks Data Source Methods

    func tracksRemoteDataSource(networkClient: RestNetworkClientProtocol) -> TracksDataSource {
        return TracksRemoteDataSource(networkClient: networkClient)
    }
}
