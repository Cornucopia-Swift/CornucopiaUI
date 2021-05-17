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
                                      preferredStyle: UIAlertController.Style = .alert,
                                      then: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
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
                                       preferredStyle: UIAlertController.Style = .alert,
                                       confirmHandler: @escaping((UIAlertAction) -> Void),
                                       cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let cancelAction = UIAlertAction(title: cancelTextKey.CC_localized, style: .cancel, handler: cancelHandler)
        let okAction = UIAlertAction(title: confirmTextKey.CC_localized, style: destructive ? .destructive : .default, handler: confirmHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        on.present(alert, animated: true, completion: nil)
    }

    static func CC_notYetImplemented(_ title: String = "Not Yet Implemented", on: UIViewController, then: (() -> Void)? = nil) {
        self.CC_presentInformative(on: on, title: title, message: "I'm sorry, but this feature is not implemented yet", autoDismiss: 3, preferredStyle: .alert, then: then)
    }

}
#endif
