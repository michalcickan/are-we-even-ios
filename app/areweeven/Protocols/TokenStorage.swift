import AweApi

protocol TokenStorage {
    func saveTokens(tokens: AccessToken?)
}
