import Foundation
import Alamofire

public actor Client {
    private let baseUrl: String
    private let authInterceptor: AuthRequestInterceptor
    private let deviceId: String
    let logger: Logger?
    
    public init(baseUrl: String,
                tokensProvider: TokensProvider,
                deviceId: String,
                logger: Logger? = nil) {
        self.baseUrl = baseUrl
        self.deviceId = deviceId
        self.logger = logger
        self.authInterceptor = AuthRequestInterceptor(
            tokensProvider: tokensProvider,
            tokenRefreshService: AuthService(baseUrl: baseUrl)
        )
    }
}

// MARK: - Request Methods
extension Client {
    func send<T: Decodable>(method: HTTPMethod,
                            endpoint: Endpoint,
                            parameters: Encodable) async throws -> T {
        try await sendAsyncRequest(
            request: AF.request(
                endpoint.fullUrl(with: baseUrl),
                method: method,
                parameters: parameters,
                headers: headers(for: endpoint),
                interceptor: authInterceptor
            )
        )
    }
    
    func send<T: Decodable>(method: HTTPMethod, endpoint: Endpoint) async throws -> T {
        try await sendAsyncRequest(
            request: AF.request(
                endpoint.fullUrl(with: baseUrl),
                method: method,
                headers: headers(for: endpoint),
                interceptor: authInterceptor
            )
        )
    }
}

// MARK: - Sending request functions
private extension Client {
    func sendAsyncRequest<T: Decodable>(request: DataRequest) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            request.responseDecodable(of: ResponseWrapper<T>.self) { response in
                switch response.result {
                case let .success(wrapper):
                    do {
                        continuation.resume(returning: try wrapper.extractModel())
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - Configurations
private extension Client {    
    func headers(for endpoint: Endpoint) -> HTTPHeaders {
        return HTTPHeaders(
            [
                .accept("application/json"),
                endpoint.shouldAddDeviceId ? .deviceId(value: deviceId) : nil
            ].compactMap { $0 }
        )
    }
}

// MARK: - Handlers
private extension Client {
    private func handleAFError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}

fileprivate extension Endpoint {
    var shouldAddDeviceId: Bool {
        switch self {
        case .token, .login, .register, .logout:
            return true
        default:
            return false
        }
    }
}
