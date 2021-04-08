//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UITextField

public extension UITextField {

    /// Returns true, when the text is either not set at all, or set to an empty string.
    var CC_isEmpty: Bool {
        guard let text = self.text else { return false }
        return text.count < 1
    }
}
