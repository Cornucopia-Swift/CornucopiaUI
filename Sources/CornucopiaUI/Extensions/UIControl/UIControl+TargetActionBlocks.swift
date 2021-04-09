//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIControl

public extension UIControl {

    /// Adds a closure (instead of a target/action pair) to handle control events
    func CC_addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {

        // private helper
        @objc class ClosureWrapper: NSObject {
            let closure: ()->()

            init (_ closure: @escaping ()->()) {
                self.closure = closure
            }

            @objc func invoke () {
                closure()
            }
        }

        let sleeve = ClosureWrapper(closure)
        addTarget(sleeve, action: #selector(ClosureWrapper.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

}
#endif
