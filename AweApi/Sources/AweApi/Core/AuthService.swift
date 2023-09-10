import Alamofire

struct AuthService {
    let baseUrl: String
}

extension AuthService: TokenRefreshable {
    func refreshToken(_ refreshToken: String,
                      completionHandler: @escaping (Result<AccessToken, Error>) -> Void) {
        AF
            .request(
                Endpoint.token.fullUrl(with: baseUrl),
                method: .get,
                parameters:  RefreshTokenParameters(refreshToken: refreshToken)
            )
            .responseDecodable(of: ResponseWrapper<AccessToken>.self) { response in
                switch response.result {
                case let .success(wrapper):
                    do {
                        completionHandler(.success(try wrapper.extractModel()))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            }
    }
}
