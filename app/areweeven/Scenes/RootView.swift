import SwiftUI

struct RootView: View {
    @StateObject var authModel = AuthManager.shared
    
    var body: some View {
        NavigationView {
            AnyView(content)
        }
    }
    
    var content: any View {
        guard authModel.isAuthenticated else {
            return WelcomeView(
                viewModel: WelcomeViewModel(service: WelcomeService()),
                router: WelcomeRouter(isPresented: .constant(false))
            )
        }
        return MainTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
