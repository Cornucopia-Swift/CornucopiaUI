//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIImageView

public extension UIImageView {

    static var cache: Cornucopia.Core.UrlCache = Cornucopia.Core.Cache(name: #fileID)

    /// Load image via `url` and set it. A given `placeholder` image will be used, if the image can't be loaded.
    func CC_load(from url: URL, placeholder: UIImage? = nil) {
        let urlRequest = URLRequest(url: url)
        self.CC_load(from: urlRequest)
    }

    /// Load image via `urlRequest` and set it. A given `placeholder` image will be used, if the image can't be loaded.
    func CC_load(from urlRequest: URLRequest, placeholder: UIImage? = nil) {

        let setPlaceholderIfNecessary = {
            if let placeholder = placeholder {
                DispatchQueue.main.async { self.image = placeholder }
            }
        }

        Self.cache.loadDataFor(urlRequest: urlRequest) { data in
            guard let data = data else { return setPlaceholderIfNecessary() }
            guard let image = UIImage.CC_predecodedImage(data) else { return setPlaceholderIfNecessary() }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
#endif
