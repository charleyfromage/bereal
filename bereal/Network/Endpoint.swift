import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        let urlString = "http://localhost:8080" + path

        var components = URLComponents(string: urlString)
        if queryItems.count > 0 {
            components?.queryItems = queryItems
        }

        guard let url = components?.url else {
            preconditionFailure("Invalid URL components: \(String(describing: components))")
        }

        return url
    }

    var headers: [String: Any] {
        return ["Content-Type": "application/json"]
    }
}
