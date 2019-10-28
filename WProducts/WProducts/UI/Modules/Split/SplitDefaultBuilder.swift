
import UIKit

class SplitDefaultBuilder: SplitBuilder {
    var router: SplitRouter?
    var interactorManager: SplitInteractorManager?
    var presenter: SplitPresenter?
    var view: SplitView?

    // MARK: - SplitBuilder protocol
    func buildSplitModule() -> UISplitViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UISplitViewController
    }

    // MARK: - Private
    private func buildView() {
        view = SplitViewController()
    }

    private func buildRouter() {
        guard let view = self.view as? UISplitViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        router = SplitDefaultRouter(viewController: view)
    }

    private func buildInteractor() {
        interactorManager = SplitDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    private func buildPresenter() {
        guard let interactorManager = interactorManager, let router = router, let view = view else {
            assert(false, "No dependencies available")
            return
        }
        presenter = SplitDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    private func buildCircularDependencies() {
        guard let presenter = presenter, let view = view as? SplitViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}
