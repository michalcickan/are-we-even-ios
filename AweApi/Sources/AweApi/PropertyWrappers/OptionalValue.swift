import Foundation

public enum OptionalValue<T> {
    case value(_ value: T)
    case none
}
