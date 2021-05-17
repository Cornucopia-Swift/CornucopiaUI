//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIPageViewController

public extension UIPageViewController {

    var CC_visibleViewController: UIViewController? {
        /// Return the visible view controller.
        get {
            self.viewControllers?.first
        }
        /// Set the (initially) visible view controller, calling the delegate method after completion.
        set {
            guard let vc = newValue else { return }
            self.setViewControllers([vc], direction: .forward, animated: false) { _ in
                self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
            }
        }
    }
}
#endif
