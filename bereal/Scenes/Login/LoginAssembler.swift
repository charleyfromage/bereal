final class LoginAssembler {
    static func assemble(_ view: LoginViewInterface, _ interactor: LoginInteractorInterface, _ presenter: LoginPresenterInterface) {
        /// View outputs
        view.didLoad = { [weak presenter] in
            presenter?.initialise()
        }

        view.buttonTapped = { [weak interactor] login, password in
            interactor?.logIn(login: login, password: password)
        }

        /// Interactor outputs
        interactor.didLogIn = view.navigateToHome

        interactor.loadingStateChanged = { [weak view] isLoading in
            view?.hideActivityIndicator(shouldHide: !isLoading)
            view?.disableButton(shouldEnable: !isLoading)
        }

        /// Presenter outputs
        presenter.buttonTitleChanged = view.updateButtonTitle
    }
}
