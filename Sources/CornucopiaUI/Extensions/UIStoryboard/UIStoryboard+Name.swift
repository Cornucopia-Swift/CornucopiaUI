//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIStoryboard

public extension UIStoryboard {

    var CC_name: String {
        guard let name = self.value(forKey: "name") as? String else { return "unknown" }
        return name
    }
}
