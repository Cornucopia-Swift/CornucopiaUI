//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIImageView

public extension UIImageView {

    func CC_load(from url: URL) {

        let request = URLRequest(url: url)
        Cornucopia.Core.HTTPNetworking().GET(with: request) { (result: Cornucopia.Core.HTTPResponse<Data>) in
            guard case let .success(code, data) = result, code == .OK else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
#endif
