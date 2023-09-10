import Foundation

class HomeViewModel: HomeViewModelInput {
    init(service: HomeServiceType = HomeService()) {
        
    }
}

extension HomeViewModel: HomeViewModelOutput {
    
}

extension HomeViewModel: HomeViewModelType {
    var input: HomeViewModelInput { self }
    var output: HomeViewModelOutput { self }
}
