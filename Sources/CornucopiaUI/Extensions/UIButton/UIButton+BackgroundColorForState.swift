//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIButton

public extension UIButton {

    /// Sets a background color per state.
    func CC_setBackgroundColor(_ color: UIColor, for: UIControl.State) {

        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(color.cgColor)
        //FIXME: This generates a 1x1 pixel image which will be used to cover the background.
        //I wonder how much this affects the drawing performance versus creating a larger image.
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: `for`)
    }
}
#endif
