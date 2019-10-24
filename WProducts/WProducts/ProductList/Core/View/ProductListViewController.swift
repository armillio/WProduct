
import UIKit

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - ProductListView
extension ProductListViewController: ProductListView {

}
