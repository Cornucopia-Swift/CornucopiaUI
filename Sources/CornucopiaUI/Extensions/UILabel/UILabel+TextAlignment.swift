//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UILabel

public extension UILabel {

    /// Returns the actual text alignment, depending on the LTR / RTL mode
    var CC_textAlignment: NSTextAlignment {
        switch self.textAlignment {
            case .natural:
                return self.effectiveUserInterfaceLayoutDirection == .leftToRight ? .left : .right
            default:
                return self.textAlignment
        }
    }
}
