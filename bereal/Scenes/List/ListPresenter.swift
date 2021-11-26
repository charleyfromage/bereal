typealias ListPresenterInterface = ListPresenterInputs & ListPresenterOutputs

protocol ListPresenterInputs: AnyObject {
    func initialise()
}

protocol ListPresenterOutputs: AnyObject {}

final class ListPresenter: ListPresenterInterface {
    internal func initialise() {

    }
}
