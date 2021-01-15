//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UILabel

public extension UILabel {

    override func CC_translateStrings() {
        super.CC_translateStrings()

        guard let text = self.text else { return }
        self.text = NSLocalizedString(text, comment: "")
    }

}
