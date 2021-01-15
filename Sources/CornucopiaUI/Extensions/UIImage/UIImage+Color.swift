//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIImage

public extension UIImage {

    static func CC_filledWith(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }

}
