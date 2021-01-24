//
//  TracksDataRepository.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Combine
import Foundation

struct TracksDataRepository: TracksDataSource {

    // MARK: - Properties

    private let tracksRemoteDataSource: TracksDataSource

    // MARK: - Initializer

    init(tracksRemoteDataSource: TracksDataSource) {
        self.tracksRemoteDataSource = tracksRemoteDataSource
    }

    // MARK: - TracksDataSource

    var authorizationDataSource: AuthorizationDataSource {
        tracksRemoteDataSource.authorizationDataSource
    }

    func tracks(ids: String) -> AnyPublisher<Tracks, Error> {
        tracksRemoteDataSource.tracks(ids: ids)
    }
}
