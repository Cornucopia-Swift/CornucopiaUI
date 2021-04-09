//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIControl

public extension UIControl.State {

    static var CC_selectedHighlighted = UIControl.State.selected.union(UIControl.State.highlighted)

}
#endif
