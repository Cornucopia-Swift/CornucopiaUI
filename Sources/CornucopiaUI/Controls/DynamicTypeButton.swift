//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIControl

/// A UIButton with a 'primary button' style, optimized for dynamic type.
@IBDesignable
public class CC_DynamicTypeButton: UIControl {

    static let TapAnimationDuration: TimeInterval = 0.4

    @objc public dynamic var textStyle: UIFont.TextStyle {
        get { UIFont.TextStyle(rawValue: self.label.textStyle!) }
        set { self.label.textStyle = newValue.rawValue }
    }

    @IBInspectable var text: String? {
        get { self.label.text }
        set {
            self.label.text = newValue
            self.invalidateIntrinsicContentSize()
        }
    }

    public var tappedTextAlpha: CGFloat = 0.95
    public var tappedBrightnessOffset: CGFloat = -0.1
    public var tappedBackgroundScale: CGFloat = 0.97

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.commonInit()
    }

    public override var intrinsicContentSize: CGSize {
        let labelSize = self.label.intrinsicContentSize
        return CGSize(width: labelSize.width, height: labelSize.height * 2)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.label.sizeToFit()
        self.containerView.frame = self.bounds
        self.backgroundView.frame = self.containerView.bounds
        self.label.center = self.containerView.center
        self.label.frame = self.label.frame.integral
    }

    public override func tintColorDidChange() {
        self.backgroundView.backgroundColor = self.tintColor
    }

    //MARK: - private
    private lazy var containerView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = false
        v.clipsToBounds = true
        return v
    }()
    private lazy var backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = self.tintColor
        v.isUserInteractionEnabled = false
        v.layer.cornerRadius = 12
        v.layer.cornerCurve = CALayerCornerCurve.continuous
        return v
    }()
    private lazy var label: CC_DynamicTypeLabel = {
        let v = CC_DynamicTypeLabel()
        v.isUserInteractionEnabled = false
        v.textColor = .white
        return v
    }()
}

extension CC_DynamicTypeButton {

    func commonInit() {

        self.containerView.addSubview(self.backgroundView)
        self.containerView.addSubview(self.label)
        self.addSubview(self.containerView)
        self.backgroundColor = .clear

        self.addTarget(self, action: #selector(didTouchDownInside), for: [.touchDown, .touchDownRepeat])
        self.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(didDragOutside), for: [.touchDragExit, .touchCancel])
        self.addTarget(self, action: #selector(didDragInside), for: .touchDragEnter)
    }


    func updateLabelAppearance(animated: Bool = true) {

        let alpha = self.isTouchInside ? self.tappedTextAlpha : 1.0
        let closure = { self.label.alpha = alpha }
        guard animated else {
            self.label.layer.removeAnimation(forKey: "opacity")
            closure()
            return
        }
        UIView.animate(withDuration: Self.TapAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: closure, completion: nil)
    }

    func updateBackgroundAppearance(animated: Bool = true) {

        let scale = self.isTouchInside ? self.tappedBackgroundScale : 1.0
        let brightnessOffset = self.isTouchInside ? self.tappedBrightnessOffset : 0.0
        let closure = {
            self.backgroundView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            self.label.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            self.backgroundView.backgroundColor = self.tintColor.CC_brightnessAdjusted(amount: brightnessOffset)
        }
        guard animated else {
            closure()
            return
        }
        UIView.animate(withDuration: Self.TapAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: closure, completion: nil)
    }
}

extension CC_DynamicTypeButton {

    @objc func didTouchDownInside() {
        self.updateLabelAppearance()
        self.updateBackgroundAppearance()
    }

    @objc func didTouchUpInside() {
        DispatchQueue.main.async {
            self.updateLabelAppearance()
            self.updateBackgroundAppearance()
        }

        self.sendActions(for: .primaryActionTriggered)
    }

    @objc func didDragOutside() {
        self.updateLabelAppearance()
        self.updateBackgroundAppearance()
    }

    @objc func didDragInside() {
        self.updateLabelAppearance()
        self.updateBackgroundAppearance()
    }
}

public extension Cornucopia.UI { typealias DynamicTypeButton = CC_DynamicTypeButton }

#endif
