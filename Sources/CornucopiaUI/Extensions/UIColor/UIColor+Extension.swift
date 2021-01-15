//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit

public extension UIColor {

    /// Returns a color corresponding to a hexadecimal RGB representation, i.e. #ffffff for white
    static func CC_fromHex(_ hex: String) -> UIColor? {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let digits = String(hex[start...])
            let scanner = Scanner(string: digits)
            var hexNumber: UInt64 = 0

            switch digits.count {

            case 8:
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
                return nil

            case 6:
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
                }
                return nil

            default:
                return nil
            }
        }
        return nil
    }

    /// Returns a textual hexadecimal RGB representation of the color.
    func CC_toHex(includeAlpha: Bool = false) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        var string = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        if includeAlpha {
            string += String(format: "%02lX", lroundf(Float(a * 255)))
        }
        return string
    }

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
    func cc_isDark() -> Bool { !self.CC_isLight() }

}
