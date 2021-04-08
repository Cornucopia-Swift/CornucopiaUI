//
// Pretty much a shameless copy of Sam Soffes' https://github.com/soffes/GradientView
//
import CornucopiaCore
import UIKit

/// A linear or radial gradient view.
@IBDesignable public class CC_GradientView: UIView {

    private var gradient: CGGradient?

    @objc public enum Mode: Int {
        case linear
        case radial
    }

    @objc public enum Direction: Int {
        case vertical
        case horizontal
    }

    public var colors: [UIColor]? {
        didSet {
            updateGradient()
        }
    }

    public var dimmedColors: [UIColor]? {
        didSet {
            updateGradient()
        }
    }

    public var automaticallyDims: Bool = true

    public var locations: [CGFloat]? {
        didSet {
            updateGradient()
        }
    }

    @IBInspectable public var mode: Mode = .linear {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var direction: Direction = .vertical {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var drawsThinBorders: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var topBorderColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var rightBorderColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var bottomBorderColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var leftBorderColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { fatalError("Can't get context") }
        let size = bounds.size

        if let gradient = self.gradient {
            let options: CGGradientDrawingOptions = [.drawsAfterEndLocation]

            if mode == .linear {
                let startPoint = CGPoint.zero
                let endPoint = direction == .vertical ? CGPoint(x: 0, y: size.height) : CGPoint(x: size.width, y: 0)
                context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: options)
            } else {
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                context.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: min(size.width, size.height) / 2, options: options)
            }
        }

        let screen: UIScreen = window?.screen ?? UIScreen.main
        let borderWidth: CGFloat = drawsThinBorders ? 1.0 / screen.scale : 1.0

        if let color = self.topBorderColor {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: borderWidth))
        }

        let sideY: CGFloat = topBorderColor != nil ? borderWidth : 0
        let sideHeight: CGFloat = size.height - sideY - (bottomBorderColor != nil ? borderWidth : 0)

        if let color = self.rightBorderColor {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: size.width - borderWidth, y: sideY, width: borderWidth, height: sideHeight))
        }

        if let color = self.bottomBorderColor {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: size.height - borderWidth, width: size.width, height: borderWidth))
        }

        if let color = self.leftBorderColor {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: sideY, width: borderWidth, height: sideHeight))
        }
    }

    override open func tintColorDidChange() {
        super.tintColorDidChange()

        if self.automaticallyDims {
            updateGradient()
        }
    }

    override open func didMoveToWindow() {
        super.didMoveToWindow()
        self.contentMode = .redraw
    }
}

private extension CC_GradientView {

    func updateGradient() {
        self.gradient = nil
        self.setNeedsDisplay()

        guard let colors = self.gradientColors() else { return }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorSpaceModel = colorSpace.model

        let gradientColors = colors.map { (color: UIColor) -> AnyObject in
            let cgColor = color.cgColor
            let cgColorSpace = cgColor.colorSpace ?? colorSpace

            if cgColorSpace.model == colorSpaceModel {
                return cgColor as AnyObject
            }

            let (red, blue, green, alpha) = color.CC_components
            return UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor as AnyObject
        } as NSArray

        self.gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: locations)
    }

    func gradientColors() -> [UIColor]? {
        if self.tintAdjustmentMode == .dimmed {
            if let dimmedColors = dimmedColors {
                return dimmedColors
            }

            if automaticallyDims {
                if let colors = colors {
                    return colors.map {
                        var hue: CGFloat = 0
                        var brightness: CGFloat = 0
                        var alpha: CGFloat = 0

                        $0.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)

                        return UIColor(hue: hue, saturation: 0, brightness: brightness, alpha: alpha)
                    }
                }
            }
        }

        return colors
    }
}

public extension Cornucopia.UI { typealias GradientView = CC_GradientView }
