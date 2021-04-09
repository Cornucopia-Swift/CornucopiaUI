//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIView

public extension UIView {

    /// Returns the first parent view of a given type, if existing, traversing the subview hierarchy recursively.
    /// Due to type inference, there are two – functionally equivalent – ways to use this:
    /// `guard let b: UIButton = self.view.CC_firstSubview() else { return }`, or
    /// `guard let b = self.view.CC_firstSubview(of: UIButton.self)`.
    func CC_firstParentView<T: UIView>(of type: T.Type = T.self) -> T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.CC_firstParentView(of: T.self)
    }

    /// Returns the first subview of a given type, if existing, traversing the subview hierarchy recursively.
    /// Due to type inference, there are two – functionally equivalent – ways to use this:
    /// `guard let b: UIButton = self.view.CC_firstSubview() else { return }`, or
    /// `guard let b = self.view.CC_firstSubview(of: UIButton.self)`.
    func CC_firstSubview<T: UIView>(of type: T.Type = T.self) -> T? {
        for subview in self.subviews {
            if let v = subview as? T {
                return v
            } else {
                if let v: T = subview.CC_firstSubview(of: T.self) {
                    return v
                }
            }
        }
        return nil
    }

    /// Iterates through all subviews (recursively), calling `perform` on every view that is of the specified `type`.
    func CC_forEachSubview<T: UIView>(of type: T.Type = T.self, perform: (T) -> ()) {
        self.subviews.forEach {
            if $0 is T {
                perform($0 as! T)
            }
            $0.CC_forEachSubview(of: T.self, perform: perform)
        }
    }
}
#endif
