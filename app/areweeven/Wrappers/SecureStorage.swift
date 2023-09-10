import SwiftUI
import KeychainSwift

private let keychain = KeychainSwift()

@propertyWrapper
public struct SecureStorage: DynamicProperty {
    let key: StorageKey
    
    public var wrappedValue: String? {
        get {
            keychain.get(key.rawValue)
        }
        nonmutating set {
            if let newValue, !newValue.isEmpty {
                keychain.set(newValue, forKey: key.rawValue)
            }
            else {
                keychain.delete(key.rawValue)
            }
        }
    }
    
    init(_ key: StorageKey) {
        self.key = key
    }
}

enum StorageKey: String {
    case refreshToken,
         accessToken
}
