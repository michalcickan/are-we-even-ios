import Foundation
import AweApi
import Combine

final class AuthManager: ObservableObject, TokensProvider {
    static let shared = AuthManager()
    @Published var isAuthenticated: Bool!
    
    @SecureStorage(.accessToken)
    var accessToken: String? {
        didSet {
            isAuthenticated = accessToken != nil
        }
    }
    
    @SecureStorage(.refreshToken)
    var refreshToken: String?
    
    private init() {
        isAuthenticated = accessToken != nil
    }
}
