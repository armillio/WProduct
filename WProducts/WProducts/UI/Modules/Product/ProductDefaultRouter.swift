
import UIKit

class ProductDefaultRouter: ProductRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK - Navigation functions

}
