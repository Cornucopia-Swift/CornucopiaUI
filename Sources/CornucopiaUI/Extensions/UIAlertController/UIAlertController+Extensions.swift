//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIAlertController

public extension UIAlertController {

    static func CC_presentInformative(on: UIViewController,
                                      title: String = "",
                                      message: String = "",
                                      confirmTextKey: String = "OK",
                                      autoDismiss: TimeInterval? = nil,
                                      then: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let autoDismiss = autoDismiss {
            on.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + autoDismiss) {
                on.dismiss(animated: true, completion: then)
            }
        } else {
            let okAction = UIAlertAction(title: confirmTextKey.CC_localized, style: .default) { _ in
                guard let then = then else { return }
                then()
            }
            alert.addAction(okAction)
            on.present(alert, animated: true, completion: nil)
        }
    }
    
    static func CC_presentConfirmative(on: UIViewController,
                                       title: String = "",
                                       message: String = "",
                                       confirmTextKey: String = "OK",
                                       cancelTextKey: String = "CANCEL",
                                       destructive: Bool = false,
                                       confirmHandler: @escaping((UIAlertAction) -> Void),
                                       cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTextKey.CC_localized, style: .cancel, handler: cancelHandler)
        let okAction = UIAlertAction(title: confirmTextKey.CC_localized, style: destructive ? .destructive : .default, handler: confirmHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        on.present(alert, animated: true, completion: nil)
    }

}
#endif
