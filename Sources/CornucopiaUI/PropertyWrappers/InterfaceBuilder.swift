//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit

public extension Cornucopia.UI {

    @propertyWrapper
    struct IBOutlet<Value> where Value: UIView {
        var _value: Value? = nil

        public var wrappedValue: Value {
            get {
                guard let value = _value else {
                    fatalError("Property accessed before being initialized.")
                }
                return value
            }
            set {
                _value = newValue
            }
        }

        public init(_ wrappedValue: Value? = nil) {
            self._value = wrappedValue
        }

    }

} // extension Cornucopia.UI
#endif
