//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import WebKit.WKWebView

public extension WKWebView {

    func CC_applyTransparentBackground() {
        self.isOpaque = false
        self.backgroundColor = .clear
        self.scrollView.backgroundColor = .clear
    }
}

#endif
