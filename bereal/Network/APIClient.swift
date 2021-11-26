import Foundation

enum APIError: Error {
    case network(Int)
    case server(Int)
    case parsing(Error)
    case encoding
    case unknown
}

protocol APIClientInterface: AnyObject {
    typealias Headers = [String: Any]

    func get<T: Decodable>(type: T.Type, url: URL, headers: Headers, completion: @escaping (Result<T, Error>) -> Void)
    func post<T: Codable>(url: URL, headers: Headers, body: T, completion: @escaping (Result<Int?, Error>) -> Void)
}

final class APIClient: APIClientInterface {
    private let session = URLSession(configuration: .default)
    private let storage: Storage

    init(storage: Storage) {
        self.storage = storage
    }

    public func get<T: Decodable>(type: T.Type, url: URL, headers: Headers, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        urlRequest.setValue(storage.basic, forHTTPHeaderField: "Authorization")

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        let dataTask = session.dataTask(with: urlRequest){ data, response, error in
            if let data = data {
                do {
                    let entity = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }

    public func post<T: Codable>(url: URL, headers: Headers, body: T, completion: @escaping (Result<Int?, Error>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        urlRequest.setValue(storage.basic, forHTTPHeaderField: "Authorization")

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        do {
            let jsonData = try JSONEncoder().encode(body)
            urlRequest.httpBody = jsonData
        } catch {
            #if DEBUG
            print("\(error.localizedDescription)")
            #endif
        }

        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }

            completion(.success((response as? HTTPURLResponse)?.statusCode))
        }
        dataTask.resume()
    }
}
