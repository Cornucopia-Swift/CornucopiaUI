//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIWindow

public extension UIWindow {

    private func _topViewController(_ viewController: UIViewController?) -> UIViewController? {

        if let nav = viewController as? UINavigationController {
            return _topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return _topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return _topViewController(presented)
        }
        return viewController
    }

    var CC_topViewController: UIViewController? { _topViewController(self.rootViewController) }
}
#endif
