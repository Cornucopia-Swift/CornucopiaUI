//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIView

/// A decorative view for when there is no actual content.
public class CC_EmptyView: UIView {

    static let PrimaryAlpha: CGFloat = 0.65
    static let SecondaryAlpha: CGFloat = 0.6
    static let IconScaling: CGFloat = 0.35

    public required init(coder: NSCoder) {
        fatalError()
    }

    public init(icon: UIImage? = nil, title: String? = nil, subtitle: String? = nil) {
        super.init(frame: .zero)

        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = Self.SecondaryAlpha

        let titleLabel = UILabel.CC_init()
        titleLabel.alpha = Self.PrimaryAlpha
        #if !os(tvOS)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        #else
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        #endif
        titleLabel.text = title

        let subtitleLabel = UILabel.CC_init()
        subtitleLabel.alpha = Self.SecondaryAlpha
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.text = subtitle

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: Self.IconScaling),
            imageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: Self.IconScaling),
        ])
    }
}

public extension Cornucopia.UI { typealias EmptyView = CC_EmptyView }
#endif
