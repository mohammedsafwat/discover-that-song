import UIKit

class TrackCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let trackView = TrackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewHierarchy()
        setUpAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    var model: Track? {
        didSet {
            trackView.model = model
            accessibilityLabel = trackView.accessibilityLabel
        }
    }

    var style = Style() {
        didSet {
            trackView.style = style.trackViewStyle
        }
    }

    // MARK: - Public

    static func size(forWidth width:CGFloat, model: Track, style: Style) -> CGSize {
        return TrackView.sizeFor(forWidth: width - 32, style: style.trackViewStyle)
    }

    // MARK: - Private

    private func setUpViewHierarchy() {
        addSubview(trackView)
    }

    private func setUpAutoLayout() {
        trackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            trackView.topAnchor.constraint(equalTo: topAnchor),
            trackView.leftAnchor.constraint(equalTo: leftAnchor),
            trackView.rightAnchor.constraint(equalTo: rightAnchor),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension TrackCollectionViewCell {
    struct Style: Equatable {
        var backgroundColor: UIColor = .clear
        var textColor: UIColor = .darkText
        var font: UIFont = .boldSystemFont(ofSize: UIFont.systemFontSize)
        var numberOfLines: Int = 1
        var cornerRadius: CGFloat = 4
    }
}

private extension TrackCollectionViewCell.Style {
    var trackViewStyle: TrackView.Style {
        .init(backgroundColor: backgroundColor, textColor: textColor, font: font, numberOfLines: numberOfLines)
    }
}
