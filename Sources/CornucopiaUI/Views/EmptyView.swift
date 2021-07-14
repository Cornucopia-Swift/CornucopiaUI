//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIView

/// A decorative view for when there is no actual content.
public class CC_EmptyView: UIView {

    /// Construction via unarchiving not supported yet
    public required init(coder: NSCoder) {
        fatalError()
    }

    /// Create using an `icon`, a `title`, a `subtitle`.
    /// Further customization of scaling, textStyles, and alpha values is available.
    /// While the default values are good for full-screen empty views, you might want to adjust them for partial coverage.
    public init(icon: UIImage? = nil,
                title: String? = nil,
                subtitle: String? = nil,
                titleStyle: UIFont.TextStyle = .title1,
                subtitleStyle: UIFont.TextStyle = .title3,
                iconScaling: CGFloat = 0.35,
                primaryAlpha: CGFloat = 0.65,
                secondaryAlpha: CGFloat = 0.6
    ) {
        super.init(frame: .zero)

        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = secondaryAlpha

        let titleLabel = UILabel.CC_init()
        titleLabel.alpha = primaryAlpha
        titleLabel.font = UIFont.preferredFont(forTextStyle: titleStyle)
        titleLabel.text = title

        let subtitleLabel = UILabel.CC_init()
        subtitleLabel.alpha = secondaryAlpha
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: subtitleStyle)
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
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: iconScaling),
            imageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: iconScaling),
        ])
    }
}

public extension Cornucopia.UI { typealias EmptyView = CC_EmptyView }
#endif
