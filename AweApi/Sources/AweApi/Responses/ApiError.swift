import Foundation

public struct ApiError: Decodable, Error {
    public let message: String
}
