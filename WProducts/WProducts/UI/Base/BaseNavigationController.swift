
import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setNavigationBarStyleDefault()
    }

    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        self.setNavigationBarStyleDefault()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInteractivePopGestureRecognizer()
    }

    // MARK: - Configure
    func configureInteractivePopGestureRecognizer() {
        interactivePopGestureRecognizer?.delegate = self
    }

    func setNavigationBarStyleDefault() {
        navigationBar.isHidden = true
    }
}
