import Foundation

public class Group: Decodable {
    public let name: String
    public let id: Int
    public let isDefault: Bool?
    public let members: [User]?
}
