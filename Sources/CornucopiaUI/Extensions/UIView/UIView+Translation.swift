//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIView

public extension UIView {

    @objc func CC_translateStrings() {
        self.subviews.forEach { $0.CC_translateStrings() }
    }

}
