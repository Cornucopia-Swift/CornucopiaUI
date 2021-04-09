//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIView

/// A decorative view for when there is no actual content.
public class CC_EmptyView: UIView {

    public required init(coder: NSCoder) {
        fatalError()
    }

    public init(icon: UIImage? = nil, title: String? = nil, subtitle: String? = nil) {
        super.init(frame: .zero)

        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.6

        let titleLabel = UILabel()
        titleLabel.alpha = 0.65
        #if !os(tvOS)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        #else
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        #endif
        titleLabel.text = title

        let subtitleLabel = UILabel()
        subtitleLabel.alpha = 0.6
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.text = subtitle

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        self.addSubview(stackView)

        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35).isActive = true
    }
}

public extension Cornucopia.UI { typealias EmptyView = CC_EmptyView }
#endif
