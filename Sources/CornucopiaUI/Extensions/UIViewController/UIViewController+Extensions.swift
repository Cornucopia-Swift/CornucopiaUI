//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIViewController

public extension UIViewController {

    func CC_findFirstParent<T: UIViewController>(ofType: T.Type) -> T? {
        guard let parent = self.parent else { return nil }
        if parent is T {
            return parent as? T
        } else {
            return parent.CC_findFirstParent(ofType: ofType)
        }
    }

    @IBAction func CC_dismissAnimated(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: animated, completion: completion)
            return
        }

        if let navigationController = self.navigationController {

            if navigationController.viewControllers.first != self {
                navigationController.popViewController(animated: animated)
                completion?()
                return
            }

            navigationController.CC_dismissAnimated(animated, completion: completion)
            return
        }

        print("Sorry, but I don't know how to dismiss myself :-(")
    }
}
#endif
