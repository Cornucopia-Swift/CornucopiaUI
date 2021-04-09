//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIViewController

public extension UIViewController {

    func CC_translateStrings() {

        if let title = self.navigationItem.title {
            self.navigationItem.title = title.CC_localized
        }
        self.view.CC_translateStrings()
    }
}
#endif
