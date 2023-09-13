import Foundation

/// Protocol providing tokens from outside of the library
public protocol TokensProvider: AnyObject {
    var accessToken: String? { get }
    var refreshToken: String? { get }
}
