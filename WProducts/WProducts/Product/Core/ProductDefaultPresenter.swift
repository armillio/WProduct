
import Foundation

struct ProductViewModel {

}

// MARK: - Main Class
class ProductDefaultPresenter: ProductPresenter {
    private let interactorManager: ProductInteractorManager
    private let router: ProductRouter
    private weak var view: ProductView?

    private let viewModelBuilder = ProductViewModelBuilder()

    init(interactorManager: ProductInteractorManager, router: ProductRouter, view: ProductView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - ProductPresenter

}

// MARK: - Model Builder
class ProductViewModelBuilder {
    func buildViewModel() -> ProductViewModel {
        return ProductViewModel()
    }
}
