//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIButton

public extension UIButton {

    /// Enables or disables an auto toggle mode, in which tapping the button
    /// toggles the `isSelected` state and sends actions for `.valueChanged`.
    @objc var CC_isAutoToggle: Bool {
        get {
            self.title(for: .application) == "autoToggle"
        }
        set {
            if newValue && !self.CC_isAutoToggle {
                self.addTarget(self, action: #selector(_performToggle), for: .touchUpInside)
            } else if !newValue && self.CC_isAutoToggle {
                self.removeTarget(self, action: #selector(_performToggle), for: .touchUpInside)
            }
        }
    }

}

private extension UIButton {

    @objc func _performToggle() {
        self.isSelected.toggle()
        self.sendActions(for: .valueChanged)
    }

}
