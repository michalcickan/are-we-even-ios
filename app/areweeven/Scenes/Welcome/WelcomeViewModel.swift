import Foundation

class WelcomeViewModel: WelcomeViewModelInput {
    init(service: WelcomeService) {
        
    }
}

extension WelcomeViewModel: WelcomeViewModelOutput {
    
}

extension WelcomeViewModel: WelcomeViewModelType {
    var input: WelcomeViewModelInput { self }
    var output: WelcomeViewModelOutput { self }
}
