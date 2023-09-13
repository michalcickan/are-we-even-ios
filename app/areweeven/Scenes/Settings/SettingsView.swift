import Foundation
import SwiftUI

struct SettingsView<R: SettingsRouterType, VM: SettingsViewModelType>: View {
    @StateObject private var viewModel: VM
    @StateObject private var router: R
    
    init(viewModel: VM, router: R) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        List(viewModel.output.sections) { section in
            Section(section.title) {
                ForEach(section.items) {
                    ListItemCellView(viewModel: $0)
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(L10n.SettingsTab.title)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            viewModel: SettingsViewModel(),
            router: SettingsRouter(isPresented: .constant(false))
        )
    }
}
