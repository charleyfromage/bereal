typealias LoginPresenterInterface = LoginPresenterInputs & LoginPresenterOutputs

protocol LoginPresenterInputs: AnyObject {
    func initialise()
}

protocol LoginPresenterOutputs: AnyObject {
    var buttonTitleChanged: ((String?) -> Void)? { get set }
}

final class LoginPresenter: LoginPresenterInterface {
    var buttonTitleChanged: ((String?) -> Void)?

    internal func initialise() {
        buttonTitleChanged?("Log in!")  // This should come from some ViewModel
    }
}
