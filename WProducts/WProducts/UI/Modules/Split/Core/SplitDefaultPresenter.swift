
import Foundation

// MARK: - Main Class
class SplitDefaultPresenter: SplitPresenter {
    private let interactorManager: SplitInteractorManager
    private let router: SplitRouter
    private weak var view: SplitView?
    
    init(interactorManager: SplitInteractorManager, router: SplitRouter, view: SplitView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - SplitPresenter

}
