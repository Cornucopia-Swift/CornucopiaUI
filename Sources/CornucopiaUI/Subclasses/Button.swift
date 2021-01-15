//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit.UIButton

/// A `UIButton` subclass that fixes autolayout issues in iOS when applying non-zero title and/or content edge insets.
public class CC_UIButton: UIButton {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize

        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right + contentEdgeInsets.left + contentEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom + contentEdgeInsets.top + contentEdgeInsets.bottom

        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}

/// Put it into our namespace for a nicer syntax when creating programmatically
public extension Cornucopia.UI { typealias Button = CC_UIButton }
