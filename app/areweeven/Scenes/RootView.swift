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
            return WelcomeView(router: WelcomeRouter(isPresented: .constant(false)))
        }
        return HomeView(router: HomeRouter(isPresented: .constant(false)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
