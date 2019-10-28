
import Foundation

protocol ProductCoordinatorDelegate:class{
    func getSelectedProduct(withProduct product: ProductViewModel)
}

class ProductCoordinator {
    static let shared = ProductCoordinator()
    
    private let multicastDelegate = MulticastDelegate<ProductCoordinatorDelegate>()
    
    func addDelegate(_ delegate: ProductCoordinatorDelegate) {
        multicastDelegate.addDelegate(delegate)
    }
    
    func removeDelegate(_ delegate: ProductCoordinatorDelegate) {
        multicastDelegate.removeDelegate(delegate)
    }

    func invokeGetSelectedProduct(withProduct product: ProductViewModel) {
        multicastDelegate.invokeDelegates { (delegate) in
            delegate.getSelectedProduct(withProduct: product)
        }
    }
}
