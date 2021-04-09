//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import WebKit.WKWebViewConfiguration

public extension WKWebViewConfiguration {

    static func CC_withFullscreenViewportUserContentController() -> WKWebViewConfiguration {
        let jscript = """
                    var meta = document.createElement('meta');
                    meta.setAttribute('name', 'viewport');
                    meta.setAttribute('content', 'width=device-width');
                    document.getElementsByTagName('head')[0].appendChild(meta);
               """
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userController = WKUserContentController()
        userController.addUserScript(userScript)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }

}
#endif
