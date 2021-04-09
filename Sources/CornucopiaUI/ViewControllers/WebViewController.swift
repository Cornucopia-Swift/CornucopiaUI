//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import CornucopiaCore
import WebKit

public extension Cornucopia.UI {

    class WebViewController: UIViewController {

        public var html: String?
        public var url: URL?
        public var urlRequest: URLRequest?
        public var webView: WebView { self.view as! WebView }

        public init(with url: URL) {
            self.url = url

            super.init(nibName: nil, bundle:nil)
        }

        public init(with html: String) {
            self.html = html
            super.init(nibName: nil, bundle: nil)
        }

        public init(with urlRequest: URLRequest) {
            self.urlRequest = urlRequest
            super.init(nibName: nil, bundle: nil)
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        override public func loadView() {
            let view = WebView(frame: .zero)
            self.view = view
        }

        override public func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if self.html?.count ?? 0 > 0 {
                self.webView.loadHTMLString(self.html!, baseURL: nil)
            } else if self.url != nil {
                let request = URLRequest(url: self.url!)
                self.webView.load(request)
            } else if self.urlRequest != nil {
                self.webView.load(self.urlRequest!)
            } else {
                fatalError("Unsupported mode")
            }
        }

    }

} // extension Cornucopia.UI
#endif
