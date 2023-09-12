import Foundation

final class WelcomeViewModel: WelcomeViewModelInput {
    init(service: WelcomeServiceType = WelcomeService()) {
        
    }
}

extension WelcomeViewModel: WelcomeViewModelOutput {
    
}

extension WelcomeViewModel: WelcomeViewModelType {
    var input: WelcomeViewModelInput { self }
    var output: WelcomeViewModelOutput { self }
}
