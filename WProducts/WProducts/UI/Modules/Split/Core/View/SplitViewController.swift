
import UIKit

class SplitViewController: UISplitViewController {
    var presenter: SplitPresenter?

    convenience init(_ empty: Bool = false) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SplitViewCoordinator.shared.addDelegate(self)
    }
    
    deinit {
        SplitViewCoordinator.shared.removeDelegate(self)
    }

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
        
        self.preferredDisplayMode = .allVisible
        if let navigation = self.viewControllers.last as? UINavigationController {
            navigation.topViewController?.navigationItem.leftBarButtonItem = self.displayModeButtonItem
            navigation.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Model Builder
    
    fileprivate func productBuilder() -> ProductBuilder {
        return Container.shared.productBuilder()
    }
    
    fileprivate func productListBuilder() -> ProductListBuilder {
        return Container.shared.productListBuilder()
    }
}

// MARK: - SplitViewCoordinatorDelegate

extension SplitViewController: SplitViewCoordinatorDelegate {
    func setDelegate() {
        self.delegate = self
    }
}

// MARK: - UISplitViewControllerDelegate

extension SplitViewController: UISplitViewControllerDelegate {    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
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
