//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UILabel

public extension UILabel {

    /// Convenience initializer that takes a `numberOfLines`, `textAlignment`, and a `lineBreakMode`.
    static func CC_init(withNumberOfLines numberOfLines: Int = 0, textAlignment: NSTextAlignment = .center, lineBreakMode: NSLineBreakMode = .byWordWrapping) -> Self {
        let label = Self(frame: .zero)
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.lineBreakMode = lineBreakMode
        return label
    }
}
#endif // !os(watchOS)
