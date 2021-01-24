//
//  TracksViewModel.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Combine
import Foundation

struct TracksViewModel {

    // MARK: - Properties

    private let tracksDataSource: TracksDataSource

    // MARK: - Initializer

    init(tracksDataSource: TracksDataSource) {
        self.tracksDataSource = tracksDataSource
    }

    var tracks: AnyPublisher<Tracks, Error> {
        return tracksDataSource.tracks(ids: "3n3Ppam7vgaVa1iaRUc9Lp,3twNvmDtFQtAd5gMKedhLD")
    }
}
