//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit

public extension UITextField {

    func CC_setLeftView(_ view: UIView, mode: UITextField.ViewMode = .always) {

        self.leftView = view
        self.leftViewMode = mode
    }

    func CC_setRightView(_ view: UIView, mode: UITextField.ViewMode = .always) {

        self.rightView = view
        self.rightViewMode = mode
    }

}
#endif
