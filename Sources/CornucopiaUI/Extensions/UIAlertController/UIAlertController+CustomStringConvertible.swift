//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIAlertController

extension UIAlertController {

    /// This gives the `UIAlertController` a better description, so that you can actually identify it, when UIKit moans about a presentation error.
    public override var description: String { "<UIAlertController: %p>: \(self.title ?? ""), \(self.message ?? "")".CC_format(self) }
}
#endif // !os(watchOS)
