import Foundation

class GroupsViewModel: GroupsInput {
    init(service: GroupsServiceType = GroupsService()) {
        
    }
}

extension GroupsViewModel: GroupsOutput {
    
}

extension GroupsViewModel: GroupsViewModelType {
    var input: GroupsInput {
        get { self }
        set { }
    }
    var output: GroupsOutput { self }
}
