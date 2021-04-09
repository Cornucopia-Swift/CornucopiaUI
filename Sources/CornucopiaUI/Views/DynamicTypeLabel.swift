//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit

fileprivate var logger = Cornucopia.Core.Logger(category: "DynamicTypeSystem")

public extension UIFontDescriptor {

    /// Register `self` as default font given the `textStyle`.
    func CC_setDynamicTypeLabelDefault(for textStyle: UIFont.TextStyle) { DynamicTypeSystem.registerFontDescriptor(self, forStyle: textStyle) }
}

fileprivate final class DynamicTypeSystem {

    static public func registerFontDescriptor(_ fontDescriptor: UIFontDescriptor, forStyle: UIFont.TextStyle) {
        self.registeredFontStyles[forStyle.rawValue] = fontDescriptor
    }
    static public func registerFontDescriptor(_ fontDescriptor: UIFontDescriptor, forStyle: String) {
        self.registeredFontStyles[forStyle] = fontDescriptor
    }

    static var registeredFontStyles: [String: UIFontDescriptor] = [:]

    static func fontDescriptor(forStyle: String) -> UIFontDescriptor {
        guard let fontDescriptor = self.registeredFontStyles[forStyle] else {
            logger.notice("Did not find a registered font style for '\(forStyle)', using default")
            let textStyle = UIFont.TextStyle.init(rawValue: forStyle)
            return UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        }
        return fontDescriptor
    }
}

/// A UILabel subclass featuring custom fonts and automatic support for dynamic type.
@IBDesignable public class CC_DynamicTypeLabel: CC_Label {

    /// The preferred text style. If set, this overrides what is set via the font descriptor.
    @IBInspectable public var textStyle: String?

    var listeningForNotifications: Bool = false

    public override func willMove(toWindow: UIWindow?) {
        super.willMove(toWindow: toWindow)

        guard !composedTextStyle.isEmpty, !listeningForNotifications else { return }
        self.updateDynamicType()
        NotificationCenter.default.addObserver(self, selector: #selector(onContentSizeCategoryDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
        self.listeningForNotifications = true
    }
}

private extension CC_DynamicTypeLabel {

    var implicitTextStyle: String {
        guard let font = self.font else { return "" }
        guard let style = font.fontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.textStyle] as? String else { return ""}
        return style
    }

    var composedTextStyle: String {
        if let textStyle = self.textStyle, !textStyle.isEmpty { return textStyle }
        self.textStyle = self.implicitTextStyle
        return self.implicitTextStyle
    }

    func updateDynamicType() {
        let baseFontDescriptor = DynamicTypeSystem.fontDescriptor(forStyle: self.composedTextStyle)
        let uiFontTextStyle = UIFont.TextStyle.init(rawValue: self.composedTextStyle)
        let sizeDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: uiFontTextStyle)
        let pointSize = sizeDescriptor.pointSize
        let font = UIFont(descriptor: baseFontDescriptor, size: pointSize)
        self.font = font
    }

    @objc func onContentSizeCategoryDidChange() {
        guard self.adjustsFontForContentSizeCategory else { return }
        guard !self.composedTextStyle.isEmpty else { return }
        self.updateDynamicType()
    }

}

public extension Cornucopia.UI { typealias DynamicTypeLabel = CC_DynamicTypeLabel }
