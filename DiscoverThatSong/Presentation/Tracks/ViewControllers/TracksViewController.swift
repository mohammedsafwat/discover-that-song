//
//  TracksViewController.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

import Combine
import UIKit

public final class TracksViewController: UIViewController {

    // MARK: - NSCoding

    required init?(coder: NSCoder) {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        tracksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(coder: coder)
    }

    // MARK: - UIViewController

    public override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpAutoLayout()
        configureCollectionView()
        viewModel.$tracks.sink { [weak self] _ in self?.updateAppearance() }.store(in: &disposables)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let tracksCollectionViewInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tracksCollectionView.contentInset = tracksCollectionViewInset
        tracksCollectionView.frame = view.bounds
    }

    // MARK: - Public

    public var style = Style() {
        didSet {
            if oldValue != style {
                updateAppearance()
            }
        }
    }

    // MARK: - Private

    private func configureCollectionView() {
        tracksCollectionView.dataSource = self
        tracksCollectionView.delegate = self
        tracksCollectionView.backgroundColor = .clear
        tracksCollectionView.register(
            TrackCollectionViewCell.self,
            forCellWithReuseIdentifier: tracksCollectionViewCellIdentifier
        )
    }

    private func setUpViews() {
        view.addSubview(tracksCollectionView)
    }

    private func setUpAutoLayout() {
        tracksCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tracksCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            tracksCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tracksCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tracksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func updateAppearance() {
        tracksCollectionView.reloadData()
    }

    private let tracksCollectionView: UICollectionView
    private let tracksCollectionViewCellIdentifier = "TracksCollectionViewCellIdentifier"
    private let spacing: CGFloat = 16

    private var disposables = Set<AnyCancellable>()
    private lazy var viewModel: TracksViewModel = {
        let tracksDataSource = DataModule.shared.tracksRepository()
        return TracksViewModel(tracksDataSource: tracksDataSource)
    }()
}

// MARK: - UICollectionViewDataSource

extension TracksViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tracks.count
    }
}

// MARK: - UICollectionViewDelegate

extension TracksViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let trackCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: tracksCollectionViewCellIdentifier,
            for: indexPath
        ) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard indexPath.item < viewModel.tracks.count else {
            return UICollectionViewCell()
        }

        let track = viewModel.tracks[indexPath.item]
        trackCell.model = track
        trackCell.accessibilityTraits = .button
        return trackCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TracksViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let trackModel = viewModel.tracks[indexPath.item]
        return TrackCollectionViewCell.size(
            forWidth: view.bounds.width,
            model: trackModel,
            style: style.trackCollectionViewStyle
        )
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}

public extension TracksViewController {
    struct Model: Equatable {
        var tracks: [Track]

        init(tracks: [Track] = []) {
            self.tracks = tracks
        }
    }
}

public extension TracksViewController {
    struct Style: Equatable {
        public var backgroundColor: UIColor
        public var textColor: UIColor
        public var font: UIFont
        public var numberOfLines: Int

        public init(
            backgroundColor: UIColor = .white,
            textColor: UIColor = .darkText,
            font: UIFont = .boldSystemFont(ofSize: UIFont.systemFontSize),
            numberOfLines: Int = 1
        ) {
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.font = font
            self.numberOfLines = numberOfLines
        }
    }
}

private extension TracksViewController.Style {
    var trackCollectionViewStyle: TrackCollectionViewCell.Style {
        .init(backgroundColor: backgroundColor, textColor: textColor, font: font, numberOfLines: numberOfLines)
    }
}
