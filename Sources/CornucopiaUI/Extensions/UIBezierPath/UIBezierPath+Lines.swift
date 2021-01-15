//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIBezierPath

public extension UIBezierPath {

    /// Returns a line path.
    static func CC_line(from: CGPoint, to: CGPoint) -> UIBezierPath {
        let path: UIBezierPath = Self()
        path.move(to: from)
        path.addLine(to: to)
        return path
    }

}
