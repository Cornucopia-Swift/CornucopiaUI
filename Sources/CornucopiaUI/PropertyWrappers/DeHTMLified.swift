//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore

public extension Cornucopia.UI {

    @propertyWrapper
    struct DeHTMLified {
        private(set) var value: String = ""

        public var wrappedValue: String {
            get { value.CC_strippedFromHTML() }
            set { value = newValue }
        }

        public init(wrappedValue: String) {
            self.wrappedValue = wrappedValue
        }
    }

}

