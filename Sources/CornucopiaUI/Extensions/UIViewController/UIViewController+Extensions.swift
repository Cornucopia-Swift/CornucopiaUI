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

    @IBAction func CC_dismissAnimated(_ animated: Bool = true) {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: animated)
            return
        }

        if let navigationController = self.navigationController {

            if navigationController.viewControllers.first != self {
                navigationController.popViewController(animated: animated)
                return
            }

            navigationController.CC_dismissAnimated(animated)
            return
        }

        print("Sorry, but I don't know how to dismiss myself :-(")
    }

    //NOTE: Previously the above method had an optional parameter for the `completion` block. For some reason, this breaks using it via target/action, e.g.
    //`UIBarButtonItem(image: UIImage(namedFromLibrary: "Bosch-IC-close"), style: .plain, target: nc, action: #selector(UIViewController.CC_dismissAnimated)).
    //For this reason we have this duplication here. :-(
    @IBAction func CC_dismissAnimated(_ animated: Bool = true, completion: @escaping(() -> Void)) {
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: animated, completion: completion)
            return
        }

        if let navigationController = self.navigationController {

            if navigationController.viewControllers.first != self {
                navigationController.popViewController(animated: animated)
                completion()
                return
            }

            navigationController.CC_dismissAnimated(animated, completion: completion)
            return
        }

        print("Sorry, but I don't know how to dismiss myself :-(")
    }
}

#endif

