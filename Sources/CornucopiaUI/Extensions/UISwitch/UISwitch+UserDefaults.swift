//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(tvOS)
import CornucopiaCore
import UIKit.UISwitch

private var _userDefaults = Cornucopia.Core.AssociatedObject<UserDefaults>()
private var _userDefaultsKey = Cornucopia.Core.AssociatedObject<String>()

public extension UISwitch {

    private var userDefaults: UserDefaults! {
        get { _userDefaults[self] }
        set { _userDefaults[self] = newValue }
    }

    private var userDefaultsKey: String! {
        get { _userDefaultsKey[self] }
        set { _userDefaultsKey[self] = newValue }
    }

    func CC_bind(userDefaults: UserDefaults, key: String) {
        self.userDefaults = userDefaults
        self.userDefaultsKey = key
        self.isOn = userDefaults.bool(forKey: key)
        self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }

    @objc func valueChanged() {
        self.userDefaults?.setValue(self.isOn, forKey: self.userDefaultsKey)
    }

}
#endif

