import Foundation
import Combine

protocol LoginWithEmailInput: AnyObject {
    var emailText: String { get set }
    var passwordText: String { get set }
    
    func login()
}

protocol LoginWithEmailOutput {
    var showSuccess: PassthroughSubject<String, Never> { get }
    var buttonDisabled: Bool { get }
}

protocol LoginWithEmailViewModelType: ObservableObject {
    var input: LoginWithEmailInput { get set }
    var output: LoginWithEmailOutput { get }
}
