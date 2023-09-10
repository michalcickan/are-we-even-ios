import Foundation

public struct RegistrationParameters: Encodable {
    let password: String
    let email: String
    
    public init(password: String, email: String) {
        self.password = password
        self.email = email
    }
}
