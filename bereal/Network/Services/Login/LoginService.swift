import Foundation

protocol LoginServiceInterface: AnyObject {
    func logIn(with login: String?, and password: String?, completion: @escaping (Bool) -> Void)
}

final class LoginService: LoginServiceInterface {
    private var storage: Storage

    init(storage: Storage) {
        self.storage = storage
    }

    func logIn(with login: String?, and password: String?, completion: @escaping (Bool) -> Void) {
        // Faking a server request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            switch (login, password) {
                case ("noel", "foobar"):
                    self?.storage.login = login
                    self?.storage.password = password

                    completion(true)

                default: completion(false)
            }
        }
    }
}
