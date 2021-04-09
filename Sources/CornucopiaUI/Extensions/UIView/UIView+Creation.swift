//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIView

public extension UIView {

    static func CC_withBackgroundColor(_ color: UIColor) -> Self {
        let view = Self(frame: .zero)
        view.backgroundColor = color
        return view
    }
}
#endif
