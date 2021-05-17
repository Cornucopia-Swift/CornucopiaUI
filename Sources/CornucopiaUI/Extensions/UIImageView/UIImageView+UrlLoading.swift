//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIImageView

public extension UIImageView {

    func CC_load(from url: URL, placeholder: UIImage? = nil) {

        let request = URLRequest(url: url)
        Cornucopia.Core.HTTPNetworking().GET(with: request) { (result: Cornucopia.Core.HTTPResponse<Data>) in
            DispatchQueue.main.async {
                if let placeholder = placeholder {
                    self.image = placeholder
                }
                guard case let .success(code, data) = result, code == .OK else { return }
                guard let image = UIImage(data: data) else { return }
                self.image = image
            }
        }
    }
}
#endif
