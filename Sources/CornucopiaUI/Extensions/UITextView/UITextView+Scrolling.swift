//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UITextView

public extension UITextView {

    func CC_scrollToBottom() {
        let bottom = NSMakeRange(self.text.count - 1, 1)
        self.scrollRangeToVisible(bottom)
    }
}
#endif
