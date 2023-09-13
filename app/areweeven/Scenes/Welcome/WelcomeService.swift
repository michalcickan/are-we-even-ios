import Foundation
import AweApi

protocol WelcomeServiceType {
    func login(idToken: String) async throws -> Tokens
}

struct WelcomeService: WelcomeServiceType {
    func login(idToken: String) async throws -> Tokens {
        try await apiClient.login(parameters: LoginParameters(idToken: idToken))
    }
}
