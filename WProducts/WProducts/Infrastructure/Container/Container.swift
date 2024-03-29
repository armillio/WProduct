
import UIKit

class Container {
    static let shared = Container()
    var mainRootViewController: UISplitViewController?
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
    
    func createMainRootViewController() -> UISplitViewController? {
        guard let splitViewController = splitBuilder().buildSplitModule() else {
            assert(false, "Split Module failed to build. Check your setup.")
            return nil
        }
        return splitViewController
    }
}

extension Container {
    func sharedApplication() -> UIApplication {
        return UIApplication.shared
    }
}
