//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
#if !os(macOS)
import UIKit
#else
#endif

public extension Cornucopia.Core.HexColor {

    init(color: UIColor) {
        self.init(value: color.CC_toHex())
    }

    var uiColor: UIColor? {
        return UIColor.CC_fromHex(self.value)
    }

}
