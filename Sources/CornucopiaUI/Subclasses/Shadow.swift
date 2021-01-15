//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit.NSShadow

public class CC_Shadow: NSShadow {

    public var shadowOpacity: Float = 0
    public var shadowPath: UIBezierPath? = nil

    public required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }

    public init(path: UIBezierPath? = nil, opacity: Float = 0, offset: CGSize = .zero, radius: CGFloat = 0, color: Any? = nil) {
        super.init()
        self.shadowPath = path
        self.shadowOpacity = opacity
        self.shadowOffset = offset
        self.shadowBlurRadius = radius
        self.shadowColor = color
    }
}

public extension Cornucopia.UI { typealias Shadow = CC_Shadow }
