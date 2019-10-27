
import UIKit

class ProductListDefaultRouter: ProductListRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK - Navigation funcions
    
    func navigateToProductDetail(withProduct product: ProductViewModel) {
        if let productViewController = self.productBuilder().buildProductModule(product){
            //self.viewController?.navigationController?.pushViewController(productViewController, animated: true)
            
            let nc = UINavigationController()
            nc.viewControllers = [productViewController]
            self.viewController?.navigationController?.showDetailViewController(productViewController, sender: self)
            
        }
    }
    
    fileprivate func productBuilder() -> ProductBuilder {
        return Container.shared.productBuilder()
    }
}
