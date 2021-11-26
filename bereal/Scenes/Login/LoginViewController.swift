import UIKit

typealias LoginViewInterface = LoginViewInputs & LoginViewOutputs

protocol LoginViewInputs: ViewInputs {
    func hideActivityIndicator(shouldHide: Bool)
    func updateButtonTitle(title: String?)
    func disableButton(shouldEnable: Bool)
    func navigateToHome()
}

protocol LoginViewOutputs: ViewOutputs {
    var buttonTapped: ((String?, String?) -> Void)? { get set }
    var navigationToHomeTriggered: (() -> Void)? { get set }
}

final class LoginViewController: ViewController, LoginViewInterface {
    // MARK: Outlets
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var button: UIButton!

    // MARK: Outputs
    internal var buttonTapped: ((String?, String?) -> Void)?
    internal var navigationToHomeTriggered: (() -> Void)?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Inputs

    /// ActivityIndicator
    internal func hideActivityIndicator(shouldHide: Bool) {
        activityIndicator.isHidden = shouldHide
    }

    /// Button
    internal func updateButtonTitle(title: String?) {
        button.setTitle(title, for: .normal)
    }

    internal func disableButton(shouldEnable: Bool) {
        button.isEnabled = shouldEnable
    }

    internal func navigateToHome() {
        navigationToHomeTriggered?()
    }

    // MARK: Actions
    @IBAction func buttonTap() {
        buttonTapped?(loginTextField.text, passwordTextField.text)
    }
}
