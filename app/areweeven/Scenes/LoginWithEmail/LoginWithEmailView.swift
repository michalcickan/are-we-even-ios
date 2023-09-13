import Foundation
import SwiftUI

struct LoginWithEmailView<R: LoginWithEmailRouterType, VM: LoginWithEmailViewModelType>: View {
    @StateObject private var viewModel: VM
    @StateObject private var router: R
    
    init(viewModel: VM, router: R) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField(L10n.emailHint, text: $viewModel.input.emailText)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                SecureField(L10n.passwordHint, text: $viewModel.input.passwordText)
                    .textFieldStyle(.roundedBorder)
                Button(L10n.Login.buttonTitle) { [unowned viewModel] in
                    viewModel.input.login()
                }
                .disabled(viewModel.output.buttonDisabled)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(L10n.Login.title)
            .onReceive(viewModel.output.showSuccess) { [unowned router] _ in
                router.dismiss()
            }
        }
        .navigation(router)
    }
}

struct LoginWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginWithEmailView(
            viewModel: LoginWithEmailViewModel(),
            router: LoginWithEmailRouter(isPresented: .constant(false))
        )
    }
}
