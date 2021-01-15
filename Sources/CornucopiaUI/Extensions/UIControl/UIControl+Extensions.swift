//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIControl

public extension UIControl {

    /// An extension to the `isEnabled` call that also sets the alpha value to 1.0 (enabled) or 0.5 (disabled), respectively.
    var CC_isEnabled: Bool {
        set {
            self.isEnabled = newValue
            self.alpha = newValue ? 1.0 : 0.5
        }
        get {
            return self.isEnabled
        }
    }

}
