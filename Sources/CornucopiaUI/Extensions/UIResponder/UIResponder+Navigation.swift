//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIResponder

public extension UIResponder {

    /// Returns the next responder of a given type, if existing, traversing the responder chain.
    func CC_nextResponder<T: UIResponder>(of type: T.Type = T.self) -> T? {
        guard let responder = self.next else {
            return nil
        }
        return (responder as? T) ?? responder.CC_nextResponder(of: T.self)
    }
}

