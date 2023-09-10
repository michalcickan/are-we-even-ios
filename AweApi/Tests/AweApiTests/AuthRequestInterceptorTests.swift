import Foundation
import Quick
import Alamofire
import Nimble

@testable import AweApi

class AuthRequestInterceptorTests: QuickSpec {
    override class func spec() {
        let urlRequest = try! URLRequest(url: URL(string: "http://localhost/test")!, method: .get)
        
        describe("AuthRequestInterceptor") {
            context("bearer token") {
                it("is present is present when provider has some") {
                    let authInterceptor = AuthRequestInterceptor(
                        tokensProvider: MockTokensProvider(accessToken: "peter"),
                        tokenRefreshService: MockTokenRefreshService()
                    )
                    
                    var authorizationHeader: HTTPHeader?
                    
                    authInterceptor.adapt(urlRequest, for: .default) { result in
                        switch result {
                        case let .success(request):
                            authorizationHeader = request.headers.first(where: {
                                $0 == .authorization(bearerToken: "peter")
                            })
                        default:
                            authorizationHeader = nil
                        }
                    }
                    expect(authorizationHeader).toEventuallyNot(beNil())
                }
                
                it("is not present when provider doesn't have any") {
                    let authInterceptor = AuthRequestInterceptor(
                        tokensProvider: MockTokensProvider(),
                        tokenRefreshService: MockTokenRefreshService()
                    )
                    var authorizationHeader: HTTPHeader? = HTTPHeader.authorization("test")
                    
                    authInterceptor.adapt(urlRequest, for: .default) { result in
                        switch result {
                        case let .success(request):
                            authorizationHeader = request.headers.first(where: {
                                $0.name == HTTPHeader.authorization("").name
                            })
                        default:
                            authorizationHeader = nil
                        }
                    }
                       
                    expect(authorizationHeader).toEventually(beNil())
                }
            }
            
            context("refresh token") {
                it("call refresh token on 401 status code and token provider has refresh token") {
                    let tokensProvider = MockTokensProvider(refreshToken: "test")
                    let tokenRefreshService = MockTokenRefreshService()
                    let authInterceptor = AuthRequestInterceptor(tokensProvider: tokensProvider, tokenRefreshService: tokenRefreshService)
                    
                    let url = URL(string: "http://localhost/test")!
                    let urlRequest = try URLRequest(url: url, method: .get)
                    let request = Session.default.request(urlRequest)
                    authInterceptor.retry(
                        request,
                        for: Session.default,
                        dueTo: AFError.responseValidationFailed(
                            reason: .unacceptableStatusCode(code: 401)
                        )
                    ) { _ in }
                    expect(tokenRefreshService.refreshTokenCalled).to(beTrue())
                }
            }
        }
    }
}

struct MockTokensProvider: TokensProvider {
    var accessToken: String?
    var refreshToken: String?
}

class MockTokenRefreshService: TokenRefreshable {
    var refreshTokenCalled = false
    
    func refreshToken(_ refreshToken: String, completionHandler: @escaping (Result<AccessToken, Error>) -> Void) {
        refreshTokenCalled = true
    }
}
