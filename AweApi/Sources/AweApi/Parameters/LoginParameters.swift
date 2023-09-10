public struct LoginParameters: Encodable {
    let idToken: String?
    let email: String?
    let password: String?
    
    public init(idToken: String? = nil,
                email: String? = nil,
                password: String? = nil) {
        self.idToken = idToken
        self.email = email
        self.password = password
    }
}
