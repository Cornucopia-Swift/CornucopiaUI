//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIView

public extension UIView {

    private static let AnimationDuration = 0.35

    /// Covers with a blur effect. If a `view` is specified, it is added on top of the blur effect.
    func CC_cover(with view: UIView? = nil, animated: Bool = true, blurStyle: UIBlurEffect.Style = .regular) {
        guard nil == self.subviews.first(where: { $0 is UIVisualEffectView }) else { fatalError("\(self) is already covered with a blur effect") }
        let effectView = UIVisualEffectView()
        //FIXME: For some reason, adding the effect view to a scroll view via auto layout ends up in a .zero frame
        if self is UIScrollView {
            effectView.frame = self.bounds
            effectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.addSubview(effectView)
        } else {
            self.CC_addSubview(effectView)
        }
        guard let v = view else { return }
        v.center = self.center
        effectView.contentView.addSubview(v)

        if animated {
            UIView.animate(withDuration: Self.AnimationDuration, delay: 0, options: .curveEaseInOut) {
                effectView.effect = UIBlurEffect(style: blurStyle)
            }
        } else {
            effectView.effect = UIBlurEffect(style: blurStyle)
        }
    }

    /// Uncovers from the blur effect.
    func CC_uncover(animated: Bool = true) {
        guard let effectView = self.subviews.first(where: { $0 is UIVisualEffectView }) as? UIVisualEffectView else { fatalError("\(self) is not covered with a blur effect") }
        if animated {
            UIView.animate(withDuration: Self.AnimationDuration, delay: 0, options: .curveEaseInOut) {
                effectView.effect = nil
            } completion: { _ in
                effectView.removeFromSuperview()
            }
        } else {
            effectView.removeFromSuperview()
        }
    }
}
#endif
