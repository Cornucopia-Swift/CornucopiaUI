//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import CornucopiaCore
import WebKit

/// A `WKWebView` subclass that works around two common issues of the stock `WKWebView`:
/// - The default viewport is not set, hence most web pages render in a very tiny fraction of the view.
/// - The intrinsic content size is not set (and recalculated after loading is complete) based on the actual content.
public class CC_WebView: WKWebView {

    private static let LoadingKeyPath = "loading"
    private static let JSDocumentReadyState = "document.readyState"

    public init(frame: CGRect = .zero) {
        let configuration = WKWebViewConfiguration.CC_withFullscreenViewportUserContentController()
        super.init(frame: frame, configuration: configuration)
        self.addObserver(self, forKeyPath: Self.LoadingKeyPath, options: .new, context: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configuration.userContentController.addUserScript(WKUserScript.CC_withFullscreenViewport())
        self.addObserver(self, forKeyPath: Self.LoadingKeyPath, options: .new, context: nil)
    }

    public override var intrinsicContentSize: CGSize {
        return self.scrollView.contentSize
    }
}

public extension CC_WebView {

    /// The intrinsic content size can only be properly reported once page loading has been completed.
    /// To not infer with the `navigationDelegate` (which might be used at the call site), we do this
    /// via KVO the 'loading' property.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Self.LoadingKeyPath && !self.isLoading {
            self.evaluateJavaScript(Self.JSDocumentReadyState, completionHandler: { (_, _) in
                self.invalidateIntrinsicContentSize()
            })
        }
    }
}

public extension Cornucopia.UI { typealias WebView = CC_WebView }

#endif
