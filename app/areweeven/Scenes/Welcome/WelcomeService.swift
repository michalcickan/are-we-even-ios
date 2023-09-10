import Foundation
import AweApi

protocol WelcomeServiceType {
    func login(idToken: String) async throws -> AccessToken
}

struct WelcomeService: WelcomeServiceType {
    func login(idToken: String) async throws -> AccessToken {
        try await apiClient.login(parameters: LoginParameters(idToken: idToken))
    }
}
