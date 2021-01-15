//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit

public class CC_LineView: UIView {

    //TODO: Make @IBDesignable etc.
    public required init?(coder: NSCoder) {
        fatalError()
    }

    public init(axis: NSLayoutConstraint.Axis = .horizontal, color: UIColor, width: CGFloat = 1.0) {
        super.init(frame: .zero)
        self.backgroundColor = color
        if axis == .horizontal {
            self.heightAnchor.constraint(equalToConstant: width).isActive = true
        } else {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

public extension Cornucopia.UI {

    typealias LineView = CC_LineView

}
