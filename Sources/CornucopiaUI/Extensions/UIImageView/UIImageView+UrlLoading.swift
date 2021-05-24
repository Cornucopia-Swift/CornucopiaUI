//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIImageView

public extension UIImageView {

    func CC_load(from url: URL, placeholder: UIImage? = nil) {

        let setPlaceholderIfNecessary = {
            if let placeholder = placeholder {
                DispatchQueue.main.async { self.image = placeholder }
            }
        }

        let request = URLRequest(url: url)
        Cornucopia.Core.HTTPNetworking().GET(with: request) { (result: Cornucopia.Core.HTTPResponse<Data>) in
            guard case let .success(code, data) = result, code == .OK else { return setPlaceholderIfNecessary() }
            guard let image = UIImage.CC_predecodedImage(data) else { return setPlaceholderIfNecessary() }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
#endif
