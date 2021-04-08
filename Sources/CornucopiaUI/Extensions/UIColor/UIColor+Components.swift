//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIColor

public extension UIColor {

    /// The RGBA components as a tuple. This is a much nicer API than `UIColor.get`
    var CC_components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
