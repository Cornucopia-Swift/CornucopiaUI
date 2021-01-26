//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIView

public extension UIView {

    private static let AnimationBounceKey = "bounce"
    private static let AnimationKeyPathScale = "transform.scale"

    func CC_animateContentChangeOnMainLayerByFading(with duration: TimeInterval = 0.33) {
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.type = .fade
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fillMode = CAMediaTimingFillMode(rawValue: "extended")
        self.layer.add(animation, forKey: nil)
    }

    func CC_bounceOnce() {
        guard self.layer.animation(forKey: Self.AnimationBounceKey) == nil else { return }
        let animation = CABasicAnimation(keyPath: Self.AnimationKeyPathScale)
        animation.fromValue = 1.0
        animation.toValue = 1.2
        animation.autoreverses = true
        animation.duration = 0.15
        self.layer.add(animation, forKey: Self.AnimationBounceKey)
    }

}
