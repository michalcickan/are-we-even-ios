import Foundation

/// Protocol providing tokens from outside of the library
public protocol TokensProvider {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}
