//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.NSTextAttachment

public extension NSTextAttachment {

    var CC_attributedString: NSAttributedString { NSAttributedString(attachment: self) }

}
