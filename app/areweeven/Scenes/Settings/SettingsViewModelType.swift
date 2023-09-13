import Foundation
import Combine

protocol  SettingsInput: AnyObject {
    
}

protocol  SettingsOutput {
    var sections: [ListSection<ListItemCellViewModel>] { get }
}

protocol  SettingsViewModelType: ObservableObject {
    var input:  SettingsInput { get set }
    var output:  SettingsOutput { get }
}
