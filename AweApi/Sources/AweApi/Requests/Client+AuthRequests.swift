import Foundation

public extension Client {
    func login(parameters: LoginParameters, loginType: LoginType? = nil) async throws -> AccessToken {
        try await send(method: .get, endpoint: .login(loginType), parameters: parameters)
    }
    
    func logout() async throws -> AccessToken {
        try await send(method: .post, endpoint: .logout)
    }

    func register(parameters: RegistrationParameters) async throws -> AccessToken {
        try await send(method: .post, endpoint: .register, parameters: parameters)
    }
}
