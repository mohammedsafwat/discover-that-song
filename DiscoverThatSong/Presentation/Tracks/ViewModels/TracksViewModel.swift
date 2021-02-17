//
//  TracksViewModel.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Combine
import Foundation

class TracksViewModel {

    // MARK: - Internal

    @Published var tracks: [Track] = []

    // MARK: - Initializer

    init(tracksDataSource: TracksDataSource) {
        self.tracksDataSource = tracksDataSource
        fetchTracks()
    }

    private func fetchTracks() {
        tracksDataSource
            .tracks(ids: "3n3Ppam7vgaVa1iaRUc9Lp,3twNvmDtFQtAd5gMKedhLD")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.tracks = []
                    print("ERROR: An error happened while fetching the tracks: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] tracks in
                guard let self = self else { return }
                self.tracks = tracks.tracks
            }.store(in: &disposables)

    }

    // MARK: - Private

    private let tracksDataSource: TracksDataSource
    private var disposables = Set<AnyCancellable>()
}
