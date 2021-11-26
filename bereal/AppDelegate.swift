//
//  AppDelegate.swift
//  bereal
//
//  Created by Fromage Charley on 25/11/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let storage = Storage()
    var apiClient: APIClientInterface?

    // The following attributes should obviously be retained elsewhere (for instance with some dependencies manager)
    var loginInteractor: LoginInteractor?
    var loginPresenter: LoginPresenter?

    var listInteractor: ListInteractor?
    var listPresenter: ListPresenter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        apiClient = APIClient(storage: storage)

        window = UIWindow(frame: UIScreen.main.bounds)

        /// This should be delegated to some routing layer (for instance with a coordinator pattern)
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            let loginService = LoginService(storage: storage)
            let loginInteractor = LoginInteractor(loginService: loginService, listService: ListService(apiClient: apiClient))
            self.loginInteractor = loginInteractor

            let loginPresenter = LoginPresenter()
            self.loginPresenter = loginPresenter

            LoginAssembler.assemble(loginViewController, loginInteractor, loginPresenter)

            window?.rootViewController = loginViewController
            window?.makeKeyAndVisible()

            loginViewController.navigationToHomeTriggered = { [weak self] in
                guard let self = self else { return }

                let storyboard = UIStoryboard(name: "ListView", bundle: nil)
                if let listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                    let listService = ListService(apiClient: self.apiClient)
                    let listInteractor = ListInteractor(listService: listService)
                    self.listInteractor = listInteractor

                    let listPresenter = ListPresenter()
                    self.listPresenter = listPresenter

                    ListAssembler.assemble(listViewController, listInteractor, listPresenter)

                    self.window?.rootViewController = listViewController
                }
            }
        }

        return true
    }
}
