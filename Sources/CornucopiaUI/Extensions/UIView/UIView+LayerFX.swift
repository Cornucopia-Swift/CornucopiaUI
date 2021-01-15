//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIView

public extension UIView {

    @available(*, deprecated: 0)
    func CC_setLayerEffects(borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        if let bw = borderWidth {
            self.layer.borderWidth = bw
        }
        if let bc = borderColor {
            self.layer.borderColor = bc.cgColor
        }
        if let cr = cornerRadius {
            self.layer.cornerRadius = cr
        }
    }
}
