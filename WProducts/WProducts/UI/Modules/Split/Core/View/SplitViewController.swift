
import UIKit

class SplitViewController: UISplitViewController {
    var presenter: SplitPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let list = UINavigationController()
        let detail = UINavigationController()
        
        guard let productViewController = self.productBuilder().buildProductModule(nil) else{ return }
        guard let productListViewController = self.productListBuilder().buildProductListModule() else{ return }
        
        list.viewControllers = [productListViewController]
        detail.viewControllers = [productViewController]
        
        list.navigationItem.leftItemsSupplementBackButton = true
        list.navigationItem.leftBarButtonItem = self.displayModeButtonItem
        
        self.viewControllers = [list, detail]
    }

    // MARK: - Model Builder
    
    fileprivate func productBuilder() -> ProductBuilder {
        return Container.shared.productBuilder()
    }
    
    fileprivate func productListBuilder() -> ProductListBuilder {
        return Container.shared.productListBuilder()
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        
        //        guard let productViewController = self.productBuilder().buildProductModule(nil) else{ return false }
        //        guard let productListViewController = self.productListBuilder().buildProductListModule() else{ return false }
        
        guard let topAsDetailController = secondaryAsNavController.topViewController as? ProductViewController else { return false }
        
        if topAsDetailController.product == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

// MARK: - SplitView
extension SplitViewController: SplitView {
    
}
