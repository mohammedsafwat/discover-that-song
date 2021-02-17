import UIKit

class TrackCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let trackView = TrackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewHierarchy()
        setUpAutoLayout()
        updateAppearance()
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

    private func updateAppearance() {
        layer.shadowColor = style.shadowColor.cgColor
        layer.shadowOffset = style.shadowSize
        layer.shadowRadius = style.shadowRadius
        layer.shadowOpacity = style.shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        layer.cornerRadius = style.cornerRadius
    }
}

extension TrackCollectionViewCell {
    struct Style: Equatable {
        var backgroundColor: UIColor = .clear
        var textColor: UIColor = .darkText
        var font: UIFont = .boldSystemFont(ofSize: UIFont.systemFontSize)
        var numberOfLines: Int = 1
        var cornerRadius: CGFloat = 16.0
        var shadowColor: UIColor = .gray
        var shadowSize: CGSize = CGSize(width: 5, height: 15)
        var shadowRadius: CGFloat = 16.0
        var shadowOpacity: Float = 0.7
    }
}

private extension TrackCollectionViewCell.Style {
    var trackViewStyle: TrackView.Style {
        .init(backgroundColor: backgroundColor, textColor: textColor, font: font, numberOfLines: numberOfLines)
    }
}
