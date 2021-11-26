final class ListAssembler {
    static func assemble(_ view: ListViewInterface, _ interactor: ListInteractorInterface, _ presenter: ListPresenterInterface) {
        view.didAppear = { [weak interactor] in
            interactor?.fetchItems(in: "A")
        }
    }
}
