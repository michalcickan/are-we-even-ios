import Foundation

public struct Tokens: Decodable, Encodable {
    public let accessToken: String
    public let refreshToken: String
    @DateTransformer
    public var expiryDate: Date
}
