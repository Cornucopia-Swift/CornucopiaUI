//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UILabel

public extension UILabel {

    /// Returns the actual text alignment, depending on the LTR / RTL mode
    var CC_textAlignment: NSTextAlignment {
        switch self.textAlignment {
            case .natural: self.effectiveUserInterfaceLayoutDirection == .leftToRight ? .left : .right
            default:       self.textAlignment
        }
    }
}
#endif
