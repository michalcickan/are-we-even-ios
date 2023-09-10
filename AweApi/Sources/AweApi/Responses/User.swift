import Foundation

public struct User: Decodable {
    public let id: Int64
    public let name: String?
    public let middleName: String?
    public let surname: String?
    public let addresses: [Address]?
    public let email: String
}
