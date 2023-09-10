import Foundation

protocol HomeViewModelInput {
    
}

protocol HomeViewModelOutput {
    
}

protocol HomeViewModelType: ObservableObject {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}
