import Foundation

protocol WelcomeRouterType: Router {
    func showLogin()
    func showGoogleLogin()
    func showRegistration()
}

final class WelcomeRouter: Router, WelcomeRouterType {
    func showLogin() {
        let router = WelcomeRouter(isPresented: isNavigating)
        navigateTo(
            WelcomeView(router: router)
        )
    }
    
    func showGoogleLogin() {
        
    }
    
    func showRegistration() {
        
    }
}
