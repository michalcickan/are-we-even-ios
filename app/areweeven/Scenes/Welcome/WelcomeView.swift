import SwiftUI
import GoogleSignInSwift

struct WelcomeView<R: WelcomeRouterType, VM: WelcomeViewModelType>: View {
    @StateObject private var viewModel: VM
    @StateObject private var router: R
    
    init(viewModel: VM = WelcomeViewModel(service: WelcomeService()),
         router: R) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            SocialButton(kind: .google) {
                router.showGoogleLogin()
            }
            SocialButton(kind: .email) {
                router.showLogin()
            }
            TextDivider(text: L10n.or.uppercased())
                .padding(.vertical, 20)
            Button(L10n.signUp) {
                router.showRegistration()
            }
            .padding(10)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 1)
            )
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(
            router: WelcomeRouter(isPresented: .constant(false))
        )
    }
}
