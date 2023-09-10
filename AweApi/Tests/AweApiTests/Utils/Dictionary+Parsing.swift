import Foundation

extension Dictionary<String, Any> {
    func parse<T: Decodable>() -> T {
        let jsonData = try! JSONSerialization.data(withJSONObject: self)
        return try! JSONDecoder().decode(T.self, from: jsonData)
    }
}
