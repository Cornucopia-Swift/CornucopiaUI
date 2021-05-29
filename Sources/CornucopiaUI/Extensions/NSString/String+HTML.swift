//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit

public extension String {

    /// Returns an attributed string by parsing the receiver as HTML.
    /// If a `font` is specified, it will be used.
    func CC_attributedStringParsingHTML(font: UIFont? = nil) -> NSAttributedString {
        do {
            var text = self
            if font != nil {
                text = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(font!.pointSize)\">%@</span>", self)
            }
            guard let data = text.data(using: .unicode) else {
                return NSAttributedString(string: "<unicode conversion error>")
            }
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributed = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: "<NSAttributedString conversion error>")
        }
    }

    func CC_strippedFromHTML() -> String { return self.CC_attributedStringParsingHTML().string }

}
