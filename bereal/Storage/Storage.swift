import Foundation

class Storage {
    var login: String?
    var password: String?
    var basic: String {
        return "Basic " + ((login ?? "") + ":" + (password ?? "")).data(using: .utf8)!.base64EncodedString()
    }
}
