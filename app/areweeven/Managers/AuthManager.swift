import Foundation
import AweApi
import Combine

final class AuthManager: ObservableObject, TokensProvider {
    static let shared = AuthManager()
    @Published var isAuthenticated: Bool!
    
    @SecureStorage(.accessToken)
    var accessToken: String?
    
    @SecureStorage(.refreshToken)
    var refreshToken: String?
    
    private init() {
        isAuthenticated = accessToken != nil
    }
}

extension AuthManager: TokensStorage {
    func save(tokens: Tokens?) {
        self.accessToken = tokens?.accessToken
        self.refreshToken = tokens?.refreshToken
    }
}
