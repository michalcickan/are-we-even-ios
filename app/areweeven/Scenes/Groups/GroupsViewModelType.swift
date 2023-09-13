import Foundation
import Combine

protocol  GroupsInput: AnyObject {
    
}

protocol  GroupsOutput {
    
}

protocol  GroupsViewModelType: ObservableObject {
    var input:  GroupsInput { get set }
    var output:  GroupsOutput { get }
}
