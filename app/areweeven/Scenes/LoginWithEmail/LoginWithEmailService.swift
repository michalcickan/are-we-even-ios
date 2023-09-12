import Foundation
import AweApi

protocol LoginWithEmailServiceType {
    func login(email: String, password: String) async throws -> AccessToken
}

struct LoginWithEmailService: LoginWithEmailServiceType {
    func login(email: String, password: String) async throws -> AccessToken {
        try await apiClient.login(
            parameters: LoginParameters(email: email, password: password)
        )
    }
}
