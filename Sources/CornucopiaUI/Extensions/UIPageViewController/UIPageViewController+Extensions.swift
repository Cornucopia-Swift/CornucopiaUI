//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIPageViewController

public extension UIPageViewController {

    var CC_visibleViewController: UIViewController? {
        return self.viewControllers?.first
    }

}
#endif
