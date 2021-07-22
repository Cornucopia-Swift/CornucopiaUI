//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import WebKit.WKUserScript

public extension WKUserScript {

    static func CC_withFullscreenViewport() -> Self {
        let jscript = """
                    var meta = document.createElement('meta');
                    meta.setAttribute('name', 'viewport');
                    meta.setAttribute('content', 'width=device-width');
                    document.getElementsByTagName('head')[0].appendChild(meta);
               """
        let userScript = Self(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        return userScript
    }
}

#endif
