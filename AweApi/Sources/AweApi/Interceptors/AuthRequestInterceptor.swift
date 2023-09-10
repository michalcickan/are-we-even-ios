import Foundation
import Alamofire

protocol TokenRefreshable {
    func refreshToken(_ refreshToken: String,
                      completionHandler: @escaping (Result<AccessToken, Error>) -> Void)
}

final class AuthRequestInterceptor : RequestInterceptor {
    private var tokensProvider: TokensProvider
    private let tokenRefreshService: TokenRefreshable
    private var pendingRetries = [(RetryResult) -> Void]()
    
    var isRefreshing = false

    init(tokensProvider: TokensProvider, tokenRefreshService: TokenRefreshable) {
        self.tokensProvider = tokensProvider
        self.tokenRefreshService = tokenRefreshService
    }
    
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if let accessToken = tokensProvider.accessToken {
            request.headers.add(HTTPHeader.authorization(bearerToken: accessToken))
        }
        completion(.success(request))
    }
    
    public func retry(_ request: Request,
                      for session: Session,
                      dueTo error: Error,
                      completion: @escaping (RetryResult) -> Void) {
        guard let error = error.asAFError, error.responseCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        guard request.retryCount < 2, let refreshToken = tokensProvider.refreshToken else {
            setTokens(response: nil)
            completion(.doNotRetry)
            return
        }
        pendingRetries.append(completion)
        guard !isRefreshing else {
            return
        }
        isRefreshing = true
        
        tokenRefreshService.refreshToken(refreshToken) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                setTokens(response: data)
                completePending(result: .retry)
            case let .failure(error):
                setTokens(response: nil)
                completePending(result: .doNotRetryWithError(error))
            }
            self.isRefreshing = false
        }
    }
}

private extension AuthRequestInterceptor {
    func setTokens(response: AccessToken?) {
        tokensProvider.accessToken = response?.accessToken
        tokensProvider.refreshToken = response?.refreshToken
    }
    
    func completePending(result: RetryResult) {
        while !pendingRetries.isEmpty {
            pendingRetries.removeFirst()(result)
        }
    }
}
