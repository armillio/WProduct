
import UIKit

class Container {
    static let shared = Container()
    var mainRootViewController: UIViewController?
}

// MARK: - AppDelegate Injection

extension Container {
    func inject() -> UIWindow? {
        guard let window = window() else { return nil }
        return window
    }

    func window() -> UIWindow? {
        let window = UIWindow(frame: self.screen().bounds)
            guard let rootVC = createMainRootViewController() else { return nil }
            window.rootViewController = rootVC
            return window
    }

    func screen() -> UIScreen {
        return UIScreen.main
    }
    
    func createMainRootViewController() -> UIViewController? {
        guard let productListViewController = productListBuilder().buildProductListModule() else {
            assert(false, "Root Module failed to build. Check your DI setup.")
            return nil
        }
        let productsViewController = BaseNavigationController(rootViewController: productListViewController)
        return productsViewController
    }
}

extension Container {
    func sharedApplication() -> UIApplication {
        return UIApplication.shared
    }
}
