//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIImage

public extension UIImage {

    /// A monochrome version of `self`.
    func CC_monochrome() -> UIImage {

        guard let selfCgImage = self.cgImage else { fatalError() }

        let parameters1: [String: Any] = [
            kCIInputImageKey: CIImage(cgImage: selfCgImage),
            "inputBrightness": 0.0,
            "inputContrast": 1.1,
            "inputSaturation": 0.0,
        ]
        guard let filter1 = CIFilter(name: "CIColorControls", parameters: parameters1) else { fatalError("Can't find filter CIColorControls") }

        let parameters2: [String: Any] = [
            kCIInputImageKey: filter1.outputImage!,
            "inputEV": 0.7,
        ]
        guard let filter2 = CIFilter(name: "CIExposureAdjust", parameters: parameters2) else { fatalError("Can't find filter CIExposureAdjust") }
        let context = CIContext(options: nil)
        let output = filter2.outputImage!

        let cgImage = context.createCGImage(output, from: output.extent)
        let newImage = UIImage(cgImage: cgImage!, scale: self.scale, orientation: self.imageOrientation)
        return newImage
    }
}
#endif
