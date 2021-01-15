//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
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
        if self.navigationController != nil && self.navigationController?.viewControllers.first != self {
            self.navigationController?.popViewController(animated: animated)
        } else {
            self.presentingViewController?.dismiss(animated: animated, completion: nil)
        }
    }

}
