//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIView

public extension UIView {

    func CC_animateContentChangeOnMainLayerByFading(with duration: TimeInterval = 0.33) {
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.type = .fade
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fillMode = CAMediaTimingFillMode(rawValue: "extended")
        self.layer.add(animation, forKey: nil)
    }

}
