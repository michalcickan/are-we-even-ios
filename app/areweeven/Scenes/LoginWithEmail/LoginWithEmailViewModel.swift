import Foundation
import Combine

final class LoginWithEmailViewModel: LoginWithEmailOutput, LoginWithEmailInput {
    // MARK: - Output
    let showSuccess = PassthroughSubject<String, Never>()
    @Published var buttonDisabled: Bool = false
    
    // MARK: - Input
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    let didTapConfirm = PassthroughSubject<Void, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    private let service: LoginWithEmailServiceType
    
    init(service: LoginWithEmailServiceType = LoginWithEmailService()) {
        self.service = service
        
        Publishers.CombineLatest($emailText, $passwordText)
            .sink { [unowned self] email, password in
                self.buttonDisabled = email.isEmpty || password.isEmpty
            }
            .store(in: &cancellables)
    }
    
    func login() {
        Task {
            do {
                let result = try await service.login(
                    email: self.emailText,
                    password: self.passwordText
                )
            } catch {
                print(error)
            }
        }
    }
    
    deinit {
        print("deiniting viewmodel")
    }
}

// MARK: - Input
private extension LoginWithEmailViewModel {
    func bindInput() {
        
    }
}

extension LoginWithEmailViewModel: LoginWithEmailViewModelType {
    var input: LoginWithEmailInput {
        get { self }
        set { }
    }
    var output: LoginWithEmailOutput { self }
}
