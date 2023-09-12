import Foundation

protocol WelcomeRouterType: Router {
    func showLogin()
    func showGoogleLogin()
    func showRegistration()
}

final class WelcomeRouter: Router, WelcomeRouterType {
    func showLogin() {
        navigateTo(
            LoginWithEmailView(
                viewModel: LoginWithEmailViewModel(tokenStorage: AuthManager.shared),
                router: LoginWithEmailRouter(isPresented: isNavigating)
            )
        )
    }
    
    func showGoogleLogin() {
        
    }
    
    func showRegistration() {
        
    }
}
