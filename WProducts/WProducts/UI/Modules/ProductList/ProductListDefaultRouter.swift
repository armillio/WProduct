
import UIKit

class ProductListDefaultRouter: ProductListRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK - Navigation functions
    
    func navigateToProductDetail(withProduct product: ProductViewModel) {
        if let productViewController = self.productBuilder().buildProductModule(product){
            let navigation = UINavigationController()
            navigation.viewControllers = [productViewController]
            self.viewController?.navigationController?.showDetailViewController(productViewController, sender: self)
        }
    }
    
    fileprivate func productBuilder() -> ProductBuilder {
        return Container.shared.productBuilder()
    }
}
