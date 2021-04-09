//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIButton

public extension UIButton {

    override func CC_translateStrings() {
        super.CC_translateStrings()

        //TODO: Handle all other state combinations as well
        guard let text = self.title(for: .normal) else { return }
        self.setTitle(NSLocalizedString(text, comment: ""), for: .normal)
    }

}
#endif
