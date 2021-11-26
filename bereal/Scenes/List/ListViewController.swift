import UIKit

typealias ListViewInterface = ListViewInputs & ListViewOutputs

protocol ListViewInputs: ViewInputs {}

protocol ListViewOutputs: ViewOutputs {}

final class ListViewController: ViewController, ListViewInterface {
    // MARK: Outlets

    // MARK: Outputs

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
