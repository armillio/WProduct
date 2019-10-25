
import Foundation

struct ProductListViewModel {
    let products: [ProductViewModel]
}

// MARK: - Main Class
class ProductListDefaultPresenter: ProductListPresenter {
    private let interactorManager: ProductListInteractorManager
    private let router: ProductListRouter
    private weak var view: ProductListView?

    private let viewModelBuilder = ProductListViewModelBuilder()

    init(interactorManager: ProductListInteractorManager, router: ProductListRouter, view: ProductListView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - ProductListPresenter

    func loadData(fromRefresh refresh: Bool) {
        
    }
}

// MARK: - Model Builder
class ProductListViewModelBuilder {
    func buildViewModel(withProducts products: [Product]) -> ProductListViewModel {
        let productsViewModel = products.compactMap(ProductViewModel.init)
        return ProductListViewModel(products: productsViewModel)
    }
}
