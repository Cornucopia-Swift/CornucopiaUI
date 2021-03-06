//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIImageView

public extension UIImageView {

    static func CC_withImage(image: UIImage, contentMode: UIView.ContentMode = .scaleAspectFit) -> Self {
        let obj = Self(image: image)
        obj.contentMode = contentMode
        return obj
    }

}
#endif
