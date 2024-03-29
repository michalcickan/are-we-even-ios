import SwiftUI
import GoogleSignInSwift

struct HomeView<R: HomeRouterType, VM: HomeViewModelType>: View {
    @StateObject private var viewModel: VM
    @StateObject private var router: R
    
    init(viewModel: VM,
         router: R) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        VStack(spacing: 10) {
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: HomeViewModel(service: HomeService()),
            router: HomeRouter(isPresented: .constant(false))
        )
    }
}
