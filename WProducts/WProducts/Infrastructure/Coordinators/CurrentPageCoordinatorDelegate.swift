
import Foundation

protocol CurrentPageCoordinatorDelegate:class{
    func getCurrentPage(withPage currentPage: Int)
}

extension CurrentPageCoordinatorDelegate{
    func getCurrentPage(){}
    func getSelectedProduct(withProduct product: ProductViewModel){}
}

class CurrentPageCoordinator {
    static let shared = CurrentPageCoordinator()
    
    private let multicastDelegate = MulticastDelegate<CurrentPageCoordinatorDelegate>()
    
    func addDelegate(_ delegate: CurrentPageCoordinatorDelegate) {
        multicastDelegate.addDelegate(delegate)
    }
    
    func removeDelegate(_ delegate: CurrentPageCoordinatorDelegate) {
        multicastDelegate.removeDelegate(delegate)
    }

    func invokeGetCurrentPage(withPage currentPage: Int) {
        multicastDelegate.invokeDelegates { (delegate) in
            delegate.getCurrentPage(withPage: currentPage)
        }
    }
}
