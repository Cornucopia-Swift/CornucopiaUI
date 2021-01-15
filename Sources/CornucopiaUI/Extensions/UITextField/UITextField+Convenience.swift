//
//  File.swift
//  
//
//  Created by Dr. Michael Lauer on 04.11.20.
//

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
