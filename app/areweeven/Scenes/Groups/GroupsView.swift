import Foundation
import SwiftUI

struct GroupsView<R: GroupsRouterType, VM: GroupsViewModelType>: View {
    @StateObject private var viewModel: VM
    @StateObject private var router: R
    
    init(viewModel: VM, router: R) {
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

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(
            viewModel: GroupsViewModel(),
            router: GroupsRouter(isPresented: .constant(false))
        )
    }
}
