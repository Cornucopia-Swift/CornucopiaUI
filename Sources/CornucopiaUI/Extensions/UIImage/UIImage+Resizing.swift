//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIImage

public extension UIImage {

    /// Resizes an image to the specified size and adds an extra transparent margin at all sides of
    /// the image.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - extraMargin: the extra transparent margin to add to all sides of the image.
    ///
    /// - Returns: the resized image.  The extra margin is added to the input image size.  So that
    ///         the final image's size will be equal to:
    ///         `CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)`
    ///
    func CC_resizedImage(with size: CGSize? = nil, margin: CGFloat = 0) -> UIImage {
        let size = size ?? self.size
        let imageSize = CGSize(width: size.width + margin * 2, height: size.height + margin * 2)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        let drawingRect = CGRect(x: margin, y: margin, width: size.width, height: size.height)
        draw(in: drawingRect)

        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        return resultingImage!
    }

    /// Adds padding to an image.
    func CC_withInsets(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)

        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }

        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)

        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }

    func CC_scaledTo(newSize: CGSize, with mode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        precondition(mode == .scaleAspectFit || mode == .scaleAspectFill, "Unsupported content mode: Supported are: .scaleAspectFit and .scaleAspectFill")

        let fn: (CGFloat, CGFloat) -> (CGFloat) = mode == .scaleAspectFit ? min : max
        let ratio = fn(newSize.width / self.size.width, newSize.height / self.size.height)
        let scaledSize = CGSize(width: ratio * self.size.width, height: ratio * self.size.height)
        let origin = CGPoint(x: (newSize.width - scaledSize.width) / 2, y: (newSize.height - scaledSize.height) / 2)
        let rect = CGRect(origin: origin, size: scaledSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        return image
    }
}
