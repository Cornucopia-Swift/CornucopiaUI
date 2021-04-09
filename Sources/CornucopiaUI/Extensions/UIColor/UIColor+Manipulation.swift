//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIColor

public extension UIColor {

    func CC_brightnessAdjusted(amount: CGFloat) -> UIColor {

        let (hue, saturation, brightness, alpha) = self.CC_hsbaComponents
        var b = brightness + amount
        if b > 1.0 { b = 1.0 }
        else if b < 0.0 { b = 0.0 }
        return .init(hue: hue, saturation: saturation, brightness: b, alpha: alpha)
    }
}
