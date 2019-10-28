
import UIKit

class ProductListDefaultBuilder: ProductListBuilder {
    var router: ProductListRouter?
    var interactorManager: ProductListInteractorManager?
    var presenter: ProductListPresenter?
    var view: ProductListView?

    // MARK: - ProductListBuilder protocol
    func buildProductListModule() -> UIViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    private func buildView() {
        view = ProductListViewController()
    }

    private func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        router = ProductListDefaultRouter(viewController: view)
    }

    private func buildInteractor() {
        interactorManager = ProductListDefaultInteractorManager()
    }

    private func buildPresenter() {
        guard let interactorManager = interactorManager, let router = router, let view = view else {
            assert(false, "No dependencies available")
            return
        }
        presenter = ProductListDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    private func buildCircularDependencies() {
        guard let presenter = presenter, let view = view as? ProductListViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}
