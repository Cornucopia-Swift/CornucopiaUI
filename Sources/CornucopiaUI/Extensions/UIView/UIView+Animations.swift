//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIView

public extension UIView {

    private static let AnimationBounceKey = "bounce"
    private static let AnimationBreathingKey = "breathing"
    private static let AnimationBlinkingKey = "blinking"
    private static let AnimationKeyPathScale = "transform.scale"
    private static let AnimationKeyPathOpacity = "opacity"

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

    var CC_isBreathing: Bool {
        get {
            self.layer.animation(forKey: Self.AnimationBreathingKey) != nil
        }
        set {
            switch newValue {

                case true:
                    guard self.layer.animation(forKey: Self.AnimationBreathingKey) == nil else { return }
                    let animation = CABasicAnimation(keyPath: Self.AnimationKeyPathOpacity)
                    animation.duration = 1.5
                    animation.fromValue = 1
                    animation.toValue = 0.1
                    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    animation.autoreverses = true
                    animation.repeatCount = HUGE
                    self.layer.add(animation, forKey: Self.AnimationBreathingKey)

                case false:
                    guard self.layer.animation(forKey: Self.AnimationBreathingKey) != nil else { return }
                    self.layer.removeAnimation(forKey: Self.AnimationBreathingKey)
            }
        }
    }

    var CC_isBlinking: Bool {
        get {
            self.layer.animation(forKey: Self.AnimationBlinkingKey) != nil
        }
        set {
            switch newValue {

                case true:
                    guard self.layer.animation(forKey: Self.AnimationBlinkingKey) == nil else { return }
                    let animation = CAKeyframeAnimation(keyPath: Self.AnimationKeyPathOpacity)
                    animation.duration = 1.5
                    animation.calculationMode = .discrete
                    animation.repeatCount = HUGE
                    animation.keyTimes = [0.0, 0.5, 1.0]
                    animation.values = [1.0, 0.0, 1.0]
                    self.layer.add(animation, forKey: Self.AnimationBlinkingKey)

                case false:
                    guard self.layer.animation(forKey: Self.AnimationBlinkingKey) != nil else { return }
                    self.layer.removeAnimation(forKey: Self.AnimationBlinkingKey)
            }
        }
    }

}
