//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import WebKit.WKWebViewConfiguration

public extension WKWebViewConfiguration {

    static func CC_withFullscreenViewportUserContentController() -> WKWebViewConfiguration {
        let userController = Self.CC_fullscreenViewportUserContentController
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }

    static var CC_fullscreenViewportUserContentController: WKUserContentController = {
        let userScript = WKUserScript.CC_withFullscreenViewport()
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        return userContentController
    }()
}
#endif
