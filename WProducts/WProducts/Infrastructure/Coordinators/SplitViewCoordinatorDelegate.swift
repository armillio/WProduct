
import Foundation

protocol SplitViewCoordinatorDelegate:class{
    func setDelegate()
}

class SplitViewCoordinator {
    static let shared = SplitViewCoordinator()

    private let multicastDelegate = MulticastDelegate<SplitViewCoordinatorDelegate>()

    func addDelegate(_ delegate: SplitViewCoordinatorDelegate) {
        multicastDelegate.addDelegate(delegate)
    }

    func removeDelegate(_ delegate: SplitViewCoordinatorDelegate) {
        multicastDelegate.removeDelegate(delegate)
    }

    func invokeSetDelegate() {
        multicastDelegate.invokeDelegates { (delegate) in
            delegate.setDelegate()
        }
    }
}
