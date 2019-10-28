
import UIKit

class SplitViewController: UISplitViewController {
    var presenter: SplitPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        assignViewControllers()
        configureUI()
    }

    // MARK: - Configuration
    
    func assignViewControllers(){
        let list = UINavigationController()
        let detail = UINavigationController()
        guard let productViewController = self.productBuilder().buildProductModule(nil) else{ return }
        guard let productListViewController = self.productListBuilder().buildProductListModule() else{ return }
        
        list.viewControllers = [productListViewController]
        detail.viewControllers = [productViewController]
        
        list.navigationItem.leftItemsSupplementBackButton = true
        list.navigationItem.leftBarButtonItem = self.displayModeButtonItem
        
        self.viewControllers = [list, detail]
        self.delegate = self
    }
    
    func configureUI(){
        self.preferredDisplayMode = .allVisible
        if let navigation = self.viewControllers.last as? UINavigationController {
            navigation.topViewController?.navigationItem.leftBarButtonItem = self.displayModeButtonItem
            navigation.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Model Builder
    
    private func productBuilder() -> ProductBuilder {
        return Container.shared.productBuilder()
    }
    
    private func productListBuilder() -> ProductListBuilder {
        return Container.shared.productListBuilder()
    }
}

// MARK: - UISplitViewControllerDelegate

extension SplitViewController: UISplitViewControllerDelegate {    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? ProductViewController else { return false }
        
        if topAsDetailController.viewModel == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

// MARK: - SplitView

extension SplitViewController: SplitView {
    
}
