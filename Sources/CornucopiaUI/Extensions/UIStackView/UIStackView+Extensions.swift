//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIStackView

public extension UIStackView {

    /// Returns a horizontal stackview with the given spacing and arranged subviews
    static func CC_horizontal(spacing: CGFloat = 0, views: [UIView] = [], padding: CGFloat = 0) -> UIStackView {
        let obj = UIStackView(arrangedSubviews: views)
        obj.axis = .horizontal
        obj.spacing = spacing
        obj.distribution = .fillEqually
        if padding > 0 {
            obj.CC_setFixedPadding(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        return obj
    }

    /// Returns a vertical stackview with the given spacing and arranged subviews
    static func CC_vertical(spacing: CGFloat = 0, views: [UIView] = [], padding: CGFloat = 0) -> UIStackView {
        let obj = UIStackView(arrangedSubviews: views)
        obj.axis = .vertical
        obj.spacing = spacing
        obj.distribution = .fillEqually
        if padding > 0 {
            obj.CC_setFixedPadding(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }
        return obj
    }

    /// Sets the background color
    ///
    /// NOTE: On iOS 14 and later, the UIStackView respects the `backgroundColor` property
    func CC_setBackgroundColor(_ color: UIColor) {
        if #available(iOS 14, *) {
            self.backgroundColor = color
        } else {
            let subView = UIView(frame: bounds)
            subView.backgroundColor = color
            subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(subView, at: 0)
        }
    }

    /// Sets fixed layout margins
    func CC_setFixedPadding(_ padding: UIEdgeInsets) {
        self.layoutMargins = padding
        self.isLayoutMarginsRelativeArrangement = true
    }

    /// Sets fixed layout margins
    func CC_setFixedPadding(_ padding: CGFloat) {
        self.CC_setFixedPadding(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

    /// Sets fixed layout margins
    func CC_setFixedPadding(_ horizontal: CGFloat, vertical: CGFloat) {
        self.CC_setFixedPadding(UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal))
    }

    /// Add an empty view that acts as a stretchable area
    func CC_addStretchableArea(backgroundColor: UIColor? = nil) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: self.axis)
        if let color = backgroundColor {
            view.backgroundColor = color
        }
        self.addArrangedSubview(view)
    }

    /// Add a subview to arrange plus a spacing (along the configured axis) afterwards
    func CC_addArrangedSubview(_ view: UIView, spacing: CGFloat) {
        self.addArrangedSubview(view)
        if spacing > 0 {
            self.setCustomSpacing(spacing, after: view)
        }
    }

    /// Add an array of arranged subviews
    func CC_addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addArrangedSubview($0) }
    }

    /// Colorize all the arranged subviews
    func CCD_colorizeArrangedSubviews() {
        self.arrangedSubviews.forEach {
            if $0 is UIStackView {
                ($0 as! UIStackView).CC_setBackgroundColor(.CC_random())
            } else {
                $0.backgroundColor = .CC_random()
            }
        }
    }
}
#endif
