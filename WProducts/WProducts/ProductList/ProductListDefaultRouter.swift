
import UIKit

class ProductListDefaultRouter: ProductListRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK - Navigation funcions

    func navigateToProductDetail(withProduct product: ProductViewModel) {
    
    }
}
