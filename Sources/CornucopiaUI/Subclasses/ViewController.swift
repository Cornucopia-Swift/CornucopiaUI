//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit.UIViewController

open class CC_ViewController<T>: UIViewController {
    
    public var modelObject: T!    
}

/// Put it into our namespace for a nicer syntax when creating programmatically
public extension Cornucopia.UI { typealias ViewController = CC_ViewController }
