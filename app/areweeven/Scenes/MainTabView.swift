import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView(
                    viewModel: HomeViewModel(),
                    router: HomeRouter(isPresented: .constant(false))
                )
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text(L10n.HomeTab.title)
            }
            NavigationView {
                GroupsView(
                    viewModel: GroupsViewModel(),
                    router: GroupsRouter(isPresented: .constant(false))
                )
            }
            .tabItem {
                Image(systemName: "person.2.fill")
                Text(L10n.GroupsTab.title)
            }
            NavigationView {
                SettingsView(
                    viewModel: SettingsViewModel(),
                    router: SettingsRouter(isPresented: .constant(false))
                )
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text(L10n.SettingsTab.title)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
