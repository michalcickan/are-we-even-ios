import Foundation

protocol WelcomeViewModelInput {
    
}

protocol WelcomeViewModelOutput {
    
}

protocol WelcomeViewModelType: ObservableObject {
    var input: WelcomeViewModelInput { get }
    var output: WelcomeViewModelOutput { get }
}
