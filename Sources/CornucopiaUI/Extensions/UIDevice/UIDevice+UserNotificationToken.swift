//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIDevice

public extension UIDevice {

    /// Formats the user device token according to the PLATFORM-ENVIRONMENT-HASH scheme.
    static func CC_stringForDeviceToken(_ deviceToken: Data) -> String {
        var string = "APPLE-"
        #if DEBUG
            string += "SANDBOX-"
        #else
            string += "PRODUCTION-"
        #endif
        #if targetEnvironment(simulator)
            string += "SIMULATOR"
        #else
            string += deviceToken.map { String(format: "%02.2hhX", $0) }.joined()
        #endif
        return string
    }
}
#endif
