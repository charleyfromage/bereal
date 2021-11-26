import Foundation

protocol ListServiceInterface: AnyObject {
    func items(in fodlerName: String?, completion: @escaping ([Models.Service.Item]) -> Void)
}

final class ListService: ListServiceInterface {
    private let apiClient: APIClientInterface?

    init(apiClient: APIClientInterface?) {
        self.apiClient = apiClient
    }

    func items(in fodlerName: String?, completion: @escaping ([Models.Service.Item]) -> Void) {
        let endpoint = Endpoint.items(in: fodlerName)

        apiClient?.get(type: [Models.Service.Item].self, url: endpoint.url, headers: endpoint.headers) { response in
            switch response {
                case .success(let items): completion(items)
                case .failure: completion([])   // Should be handking error cases
            }
        }
    }
}
