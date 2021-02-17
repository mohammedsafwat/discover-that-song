import UIKit

class TrackView: UIView {

    // MARK: - Properties

    private let coverArtImageView = UIImageView()
    private let trackTitleLabel = UILabel()
    private static let imageViewSizeToCardSizeRatio: CGFloat = 0.7

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialAppearance()
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
            trackTitleLabel.text = model?.name
            let coverArtImageUrl = URL(string: model?.album.images.first?.url ?? "")
            coverArtImageView.downloaded(fromURL: coverArtImageUrl, withContentMode: .scaleAspectFill)
        }
    }

    var style = Style() {
        didSet {
            if oldValue != style {
                updateAppearance()
            }
        }
    }

    // MARK: - Public

    class func sizeFor(forWidth width: CGFloat, style: Style) -> CGSize {
        let imageSize = CGSize(width: width, height: width)
        return imageSize
    }

    // MARK: - Private

    private func setupInitialAppearance() {
        isExclusiveTouch = true
        isAccessibilityElement = true
        accessibilityTraits = .staticText
    }

    private func setUpViewHierarchy() {
        [coverArtImageView, trackTitleLabel].forEach { addSubview($0) }
    }

    private func setUpAutoLayout() {
        [coverArtImageView, trackTitleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        trackTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        trackTitleLabel.setContentHuggingPriority(.required, for: .vertical)

        NSLayoutConstraint.activate([
            trackTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            trackTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            trackTitleLabel.leftAnchor.constraint(lessThanOrEqualTo: leftAnchor, constant: 8),
            trackTitleLabel.rightAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: -8),
            coverArtImageView.topAnchor.constraint(equalTo: topAnchor),
            coverArtImageView.leftAnchor.constraint(equalTo: leftAnchor),
            coverArtImageView.rightAnchor.constraint(equalTo: rightAnchor),
            coverArtImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func updateAppearance() {
        backgroundColor = style.backgroundColor
        trackTitleLabel.font = style.font
        trackTitleLabel.numberOfLines = style.numberOfLines
        trackTitleLabel.textColor = style.textColor
        trackTitleLabel.textAlignment = .center

        layer.cornerRadius = style.cornerRadius
        layer.masksToBounds = true
    }
}

extension TrackView {
    struct Style: Equatable {
        var backgroundColor: UIColor = .gray
        var textColor: UIColor = .darkText
        var font: UIFont = .boldSystemFont(ofSize: 28)
        var numberOfLines: Int = 1
        var cornerRadius: CGFloat = 16
    }
}
