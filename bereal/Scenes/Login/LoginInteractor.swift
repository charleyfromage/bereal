import Foundation

typealias LoginInteractorInterface = LoginInteractorInputs & LoginInteractorOutputs

protocol LoginInteractorInputs: AnyObject {
    func logIn(login: String?, password: String?)
}

protocol LoginInteractorOutputs: AnyObject {
    var didLogIn: (() -> Void)? { get set }
    var loadingStateChanged: ((Bool) -> Void)? { get set }
}

final class LoginInteractor: LoginInteractorInterface {
    private var loginService: LoginServiceInterface
    private var listService: ListServiceInterface

    internal var didLogIn: (() -> Void)?
    internal var loadingStateChanged: ((Bool) -> Void)?

    private var isLoading: Bool = false {
        didSet {
            loadingStateChanged?(isLoading)
        }
    }

    init(loginService: LoginServiceInterface, listService: ListServiceInterface) {
        self.loginService = loginService
        self.listService = listService
    }

    internal func logIn(login: String?, password: String?) {
        isLoading = true

        loginService.logIn(with: login, and: password) { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false

                if success {
                    self?.didLogIn?()
                }
            }
        }
    }
}
