//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIImage

public extension UIImage {

    static func CC_predecodedImage(_ fromData: Data) -> UIImage? {

        precondition(Thread.current != Thread.main, "This method should be called on a background thread")

        guard let source = CGImageSourceCreateWithData(fromData as CFData, nil) else { return nil }
        let options: [CFString: Any] = [kCGImageSourceShouldCache: true]
        guard let cgImage = CGImageSourceCreateImageAtIndex(source, 0, options as CFDictionary) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
