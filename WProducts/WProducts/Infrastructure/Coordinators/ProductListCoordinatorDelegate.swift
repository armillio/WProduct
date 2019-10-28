
import Foundation

protocol ProductListCoordinatorDelegate:class{
    func getCurrentPage(withPage currentPage: Int)
}

/*
extension ProductListCoordinatorDelegate{
    func getCurrentPage(){}
}
*/
class ProductListCoordinator {
    static let shared = ProductListCoordinator()

    private let multicastDelegate = MulticastDelegate<ProductListCoordinatorDelegate>()

    func addDelegate(_ delegate: ProductListCoordinatorDelegate) {
        multicastDelegate.addDelegate(delegate)
    }

    func removeDelegate(_ delegate: ProductListCoordinatorDelegate) {
        multicastDelegate.removeDelegate(delegate)
    }

    func invokeGetCurrentPage(withPage currentPage: Int) {
        multicastDelegate.invokeDelegates { (delegate) in
            delegate.getCurrentPage(withPage: currentPage)
        }
    }
}
