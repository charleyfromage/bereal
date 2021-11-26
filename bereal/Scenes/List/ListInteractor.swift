import Foundation

typealias ListInteractorInterface = ListInteractorInputs & ListInteractorOutputs

protocol ListInteractorInputs: AnyObject {
    func fetchItems(in folderName: String?)
}

protocol ListInteractorOutputs: AnyObject {
    var didFetchItems: (([Models.Service.Item]) -> Void)? { get set }
    var loadingStateChanged: ((Bool) -> Void)? { get set }
}

final class ListInteractor: ListInteractorInterface {
    private var listService: ListServiceInterface

    internal var didFetchItems: (([Models.Service.Item]) -> Void)?
    internal var loadingStateChanged: ((Bool) -> Void)?

    private var isLoading: Bool = false {
        didSet {
            loadingStateChanged?(isLoading)
        }
    }

    init(listService: ListServiceInterface) {
        self.listService = listService
    }

    internal func fetchItems(in folderName: String?) {
        isLoading = true

        listService.items(in: folderName) { [weak self] items in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.didFetchItems?(items)
            }
        }
    }
}
