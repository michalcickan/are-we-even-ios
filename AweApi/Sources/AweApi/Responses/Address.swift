import Foundation

public struct Address: Decodable {
    public let street: String
    public let zip: String
    public let city: String
}
