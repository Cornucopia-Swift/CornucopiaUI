//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIStoryboard

public extension UIStoryboard {
    
    func CC_instantiateViewController<T>() -> T {

        let identifier = String(describing: T.self)
        let vc = self.instantiateViewController(identifier: identifier)
        guard let typed = vc as? T else {
            fatalError("View Controller with identifier '\(identifier)' has non-matching type in \(self.CC_name).storyboard: Expected \(T.self), got \(type(of: vc))")
        }
        return typed
    }

    func CC_instantiateInitialViewController<T>() -> T {

        guard let vc = self.instantiateInitialViewController() else {
            fatalError("Could not instantiate initial UIViewController in \(self.CC_name).storyboard")
        }
        guard let typed = vc as? T else {
            fatalError("Initial UIViewController has non-matching type in \(self.CC_name).storyboard: Expected \(T.self), got \(type(of: vc))")
        }
        return typed
    }
}
