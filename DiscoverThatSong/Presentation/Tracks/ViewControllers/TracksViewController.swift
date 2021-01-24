//
//  TracksViewController.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

import Combine
import UIKit

class TracksViewController: UIViewController {

    // MARK: - Properties

    private lazy var viewModel: TracksViewModel = {
        let tracksDataSource = DataModule.shared.tracksRepository()
        return TracksViewModel(tracksDataSource: tracksDataSource)
    }()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        if cancellable != nil {
            cancellable?.cancel()
        }

        cancellable = viewModel.tracks.sink { completion in
            switch completion {
            case .failure(let error):
                print("An error happened \(error)")
            case .finished:
                print("Finished")
            }
        } receiveValue: { tracks in
            print("tracks \(tracks)")
        }
    }
}

