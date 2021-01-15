//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIImage

public extension UIImage {

    /// Returns a colorized image.
    /// Note: This is not a simple _tint_, but rather a color layer blend mode which
    /// fits both grayscale and non-grayscale source images, preserving highlights and shadows.
    func CC_colorized(tintColor: UIColor) -> UIImage {

        return adjustedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)

            // draw original image
            context.setBlendMode(.normal)
            context.draw(self.cgImage!, in: rect)

            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            tintColor.setFill()
            context.fill(rect)

            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }

    // fills the alpha channel of the source image with the given color
    // any color information except to the alpha channel will be ignored
    func CC_alphaFilled(fillColor: UIColor) -> UIImage {

        return adjustedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
            //            context.fillCGContextFillRect(context, rect)

            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
}

private extension UIImage {

    func adjustedImage(draw: (CGContext, CGRect) -> ()) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { fatalError() }
        defer { UIGraphicsEndImageContext() }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        draw(context, rect)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        return image
    }
}
