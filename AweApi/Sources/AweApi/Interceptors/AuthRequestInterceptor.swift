import Foundation
import Alamofire

protocol TokenRefreshable {
    func refreshToken(_ refreshToken: String,
                      completionHandler: @escaping (Result<Tokens, Error>) -> Void)
}

final class AuthRequestInterceptor {
    private var tokensProvider: TokensProvider
    private let tokenRefreshService: TokenRefreshable
    private let tokenStorage: TokensStorage
    private var pendingRetries = [(RetryResult) -> Void]()
    
    var isRefreshing = false

    init(tokensProvider: TokensProvider,
         tokenRefreshService: TokenRefreshable,
         tokensStorage: TokensStorage) {
        self.tokensProvider = tokensProvider
        self.tokenRefreshService = tokenRefreshService
        self.tokenStorage = tokensStorage
    }
    
    func onResponse<T>(response: T) {
        guard let tokens = response as? Tokens else {
            return
        }
        tokenStorage.save(tokens: tokens)
    }
}

extension AuthRequestInterceptor: RequestInterceptor {
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
            tokenStorage.save(tokens: nil)
            completion(.doNotRetry)
            return
        }
        pendingRetries.append(completion)
        guard !isRefreshing else {
            return
        }
        refreshTokens(refreshToken: refreshToken)
    }
}

private extension AuthRequestInterceptor {
    func refreshTokens(refreshToken: String) {
        isRefreshing = true
        
        tokenRefreshService.refreshToken(refreshToken) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                tokenStorage.save(tokens: data)
                completePending(result: .retry)
            case let .failure(error):
                tokenStorage.save(tokens: nil)
                completePending(result: .doNotRetryWithError(error))
            }
            self.isRefreshing = false
        }
    }
    
    func completePending(result: RetryResult) {
        while !pendingRetries.isEmpty {
            pendingRetries.removeFirst()(result)
        }
    }
}
