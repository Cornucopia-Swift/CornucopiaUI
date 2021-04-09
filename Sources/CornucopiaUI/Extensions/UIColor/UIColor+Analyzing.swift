//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIColor

public extension UIColor {

    /// Returns a random color with the given alpha component.
    static func CC_random(alpha: CGFloat = 1.0) -> UIColor { UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue:  .random(in: 0...1), alpha: alpha) }

    /// Returns true, if the color is considered to be a *light* color.
    func CC_isLight() -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let colorBrightness = (red * 299) + (green * 587) + (blue * 114) / 1000;
        return colorBrightness < 0.5
    }

    /// Returns true, if the color is considered to be a *dark* color
    func CC_isDark() -> Bool { !self.CC_isLight() }
}
