//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIPageViewController

public extension UIPageViewController {

    var CC_visibleViewController: UIViewController? {
        return self.viewControllers?.first
    }

}
