import Foundation

public extension Client {
    func login(parameters: LoginParameters, loginType: LoginType? = nil) async throws -> Tokens {
        try await send(method: .post, endpoint: .login(loginType), parameters: parameters)
    }
    
    func logout() async throws -> Tokens {
        try await send(method: .post, endpoint: .logout)
    }

    func register(parameters: RegistrationParameters) async throws -> Tokens {
        try await send(method: .post, endpoint: .register, parameters: parameters)
    }
}
