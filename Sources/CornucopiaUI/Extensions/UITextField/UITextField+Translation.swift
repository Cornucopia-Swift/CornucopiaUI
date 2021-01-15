//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UITextField

public extension UITextField {

    @objc override func CC_translateStrings() {
        super.CC_translateStrings()

        guard let string = self.placeholder else { return }
        self.placeholder = NSLocalizedString(string, comment: "")

    }

}
