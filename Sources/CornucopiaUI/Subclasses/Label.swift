//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UILabel

/* A `UILabel` subclass with additional features:
   - An optional decorative line to the left and/or right.
   - An inline edit mode for one-line labels.
 */
@IBDesignable
public class CC_Label: UILabel {

    private var currentTextRect: CGRect = .zero
    private weak var editingTextField: UITextField! {
        didSet {
            print("editingTextField now \(editingTextField)")
        }
    }
    private var editingCompletionHandler: ((String) -> (Bool))!

    public var isInlineEditing: Bool { self.editingTextField != nil }

    @IBInspectable
    public var ibContentInsets: CGSize = .zero {
        didSet {
            self.contentInsets = UIEdgeInsets(top: self.ibContentInsets.height,
                                              left: self.ibContentInsets.width,
                                              bottom: self.ibContentInsets.height,
                                              right: self.ibContentInsets.width)
        }
    }

    @IBInspectable
    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable
    public var showHorizontalLine: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    public var horizontalLineColor: UIColor? = nil {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    public var horizontalLineVerticalAlignment: UIControl.ContentVerticalAlignment = .center {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    public var horizontalLineMarginCharacter: String = "n" {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override public func drawText(in rect: CGRect) {
        let rect = rect.inset(by: self.contentInsets)
        super.drawText(in: rect)

        guard self.showHorizontalLine else { return }
        self.drawHorizontalLineForText(in: rect)
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let rect = bounds.inset(by: self.contentInsets)
        self.currentTextRect = super.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        return self.currentTextRect
    }

    override public var intrinsicContentSize: CGSize {
        //guard self.numberOfLines == 0 else { fatalError() }
        var size = super.intrinsicContentSize
        if size.height != UIView.noIntrinsicMetric { size.height += self.contentInsets.top + self.contentInsets.bottom }
        if size.width != UIView.noIntrinsicMetric { size.width += self.contentInsets.left + self.contentInsets.right }
        return size
    }

    public override func tintColorDidChange() {
        super.tintColorDidChange()
        self.setNeedsDisplay()
    }

    @available(tvOS, unavailable)
    public func beginInlineEditing(with completion: @escaping( (String) -> (Bool))) {

        precondition(!self.isInlineEditing, "Inline Editing already active")

        self.editingTextField = {
            let tf = UITextField(frame: self.bounds)
            tf.backgroundColor = .systemBackground //  self.backgroundColor
            tf.font = self.font
            tf.textAlignment = self.textAlignment
            tf.textColor = self.textColor
            tf.text = self.text
            self.addSubview(tf)
            tf.delegate = self
            return tf
        }()
        self.editingCompletionHandler = completion
        self.editingTextField.becomeFirstResponder()
    }
}

@available(tvOS, unavailable)
extension CC_Label: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { textField.resignFirstResponder() }
        return false
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let completionHandler = self.editingCompletionHandler else { fatalError() }
        let editingAccepted = completionHandler(textField.text ?? "")
        if editingAccepted {
            self.text = textField.text
        }
        self.editingTextField.removeFromSuperview()
        //NOTE: This should not be neccessary, but is is, since UIKBAutofillController is holding a strong reference to our UITextField, thus leaking!
        self.editingTextField = nil
    }
}

private extension CC_Label {

    func drawHorizontalLineForText(in rect: CGRect) {

        guard let font = self.font else { return }
        let spaceWidth = self.horizontalLineMarginCharacter.size(withAttributes: [.font: font]).width

        var y: CGFloat
        switch self.horizontalLineVerticalAlignment {
            case .center:
                y = rect.origin.y + rect.size.height / 2.0
            case .top:
                y = rect.origin.y
            case .bottom:
                y = rect.origin.y + rect.size.height - 1
            case .fill:
                y = rect.origin.y + ( rect.size.height + font.ascender ) / 2.0
            @unknown default:
                y = rect.origin.y
        }

        var linesToDraw = [UIBezierPath]()

        switch self.CC_textAlignment {

            case .left:
                let p1 = CGPoint(x: self.currentTextRect.size.width + spaceWidth, y: y)
                let p2 = CGPoint(x: self.bounds.size.width, y: y)
                let rightLine = UIBezierPath.CC_line(from: p1, to: p2)
                linesToDraw.append(rightLine)

            case .center:
                let p1 = CGPoint(x: 0, y: y)
                let p2 = CGPoint(x: ( self.bounds.size.width - self.currentTextRect.size.width ) / 2.0 - spaceWidth, y: y)
                let leftLine = UIBezierPath.CC_line(from: p1, to: p2)
                linesToDraw.append(leftLine)

                let p3 = CGPoint(x: ( self.bounds.size.width + self.currentTextRect.size.width ) / 2.0 + spaceWidth, y: y)
                let p4 = CGPoint(x: self.bounds.size.width, y: y)
                let rightLine = UIBezierPath.CC_line(from: p3, to: p4)
                linesToDraw.append(rightLine)

            case .right:
                let p1 = CGPoint(x: 0, y: y)
                let p2 = CGPoint(x: self.bounds.size.width - self.currentTextRect.size.width - spaceWidth, y: y)
                let leftLine = UIBezierPath.CC_line(from: p1, to: p2)
                linesToDraw.append(leftLine)

            default:
                break
        }

        let strokeColor = self.horizontalLineColor ?? self.tintColor
        strokeColor?.setStroke()
        linesToDraw.forEach { $0.stroke() }
    }
}

public extension Cornucopia.UI { typealias Label = CC_Label }
#endif
