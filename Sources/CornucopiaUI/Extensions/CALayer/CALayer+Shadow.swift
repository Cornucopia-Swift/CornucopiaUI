//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if canImport(QuartzCore)
import QuartzCore.CALayer
import UIKit.UIColor

public extension CALayer {

    func CC_applyShadow(_ shadow: Cornucopia.UI.Shadow? = nil) {
        guard let shadow = shadow else {
            self.masksToBounds = true
            self.shadowPath = nil
            self.shadowOpacity = 0
            self.shadowColor = nil
            self.shadowRadius = 0
            self.shadowOffset = .zero
            return
        }
        self.masksToBounds = false
        self.shadowPath = shadow.shadowPath?.cgPath
        self.shadowRadius = shadow.shadowBlurRadius
        self.shadowOffset = shadow.shadowOffset
        self.shadowOpacity = shadow.shadowOpacity

        switch shadow.shadowColor {
            case let uicolor as UIColor:
                self.shadowColor = uicolor.cgColor
            case let cgcolor as CGColor:
                self.shadowColor = cgcolor
            default:
                break

        }
    }
}
#endif
