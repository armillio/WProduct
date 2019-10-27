
import UIKit

class ProductDefaultBuilder: ProductBuilder {
    var router: ProductRouter?
    var interactorManager: ProductInteractorManager?
    var presenter: ProductPresenter?
    var view: ProductView?

    // MARK: - ProductBuilder protocol
    func buildProductModule(_ product: ProductViewModel? = nil) -> UIViewController? {
        buildView(product)
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    private func buildView(_ product: ProductViewModel?) {
        view = ProductViewController(product)
    }

    private func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        router = ProductDefaultRouter(viewController: view)
    }

    private func buildInteractor() {
        interactorManager = ProductDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    private func buildPresenter() {
        guard let interactorManager = interactorManager, let router = router, let view = view else {
            assert(false, "No dependencies available")
            return
        }
        presenter = ProductDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    private func buildCircularDependencies() {
        guard let presenter = presenter, let view = view as? ProductViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}
