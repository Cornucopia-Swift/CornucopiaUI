//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIImage

public extension UIImage {

    //FIXME: Create CIFilter extensions with type-safe filter and parameter names?

    enum QRCorrectionLevel: String {
        case low = "L" // 7%
        case medium = "M" // 15%
        case quartile = "Q" // 25%
        case high = "H" // 30%
    }

    static func CC_imageWithQRCode(containing message: String, size: CGFloat, correctionLevel: QRCorrectionLevel = .medium) -> UIImage {
        let data = message.data(using: .ascii)

        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            fatalError("CIFilter CIQRCodeGenerator not available")
        }
        filter.setValue(correctionLevel.rawValue, forKey: "inputCorrectionLevel")
        filter.setValue(data, forKey: "inputMessage")
        guard let codeImage = filter.outputImage else {
            return UIImage()
        }
        let scaleX = size / codeImage.extent.size.width
        let scaleY = size / codeImage.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

        let output = codeImage.transformed(by: transform)
        return UIImage(ciImage: output)
    }
}
