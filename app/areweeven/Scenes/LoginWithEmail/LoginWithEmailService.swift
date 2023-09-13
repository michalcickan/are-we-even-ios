import Foundation
import AweApi

protocol LoginWithEmailServiceType {
    func login(email: String, password: String) async throws -> Tokens
}

struct LoginWithEmailService: LoginWithEmailServiceType {
    func login(email: String, password: String) async throws -> Tokens {
        try await apiClient.login(
            parameters: LoginParameters(email: email, password: password)
        )
    }
}
