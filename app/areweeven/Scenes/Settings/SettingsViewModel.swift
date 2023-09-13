import Foundation

class SettingsViewModel: SettingsInput {
    private(set) var sections: [ListSection<ListItemCellViewModel>]
    
    init(service: SettingsServiceType = SettingsService()) {
        sections = [
            ListSection(
                title: "",
                items: [
                    ListItemCellViewModel(
                        id: "1",
                        title: L10n.logout
                    ) {
                        print("jou")
                    }
                ]
            )
        ]
    }
}

extension SettingsViewModel: SettingsOutput {
    
}

extension SettingsViewModel: SettingsViewModelType {
    var input: SettingsInput {
        get { self }
        set { }
    }
    var output: SettingsOutput { self }
}
