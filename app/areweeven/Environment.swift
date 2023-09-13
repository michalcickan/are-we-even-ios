import Foundation

struct Environment {
    enum Key: String {
        case apiBaseUrl = "ApiBaseUrl"
    }
    
    static func value(for key: Key) -> String {
        guard let value: String = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            assertionFailure("Key \(key.rawValue)")
            return ""
        }
        return value
    }
}
