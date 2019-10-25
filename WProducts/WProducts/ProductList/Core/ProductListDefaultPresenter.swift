
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
        interactorManager.getProductListData(withPage: 1, pageSize: 30) { (products, error) in
            if error != nil {
                //self.view?.displayEmptyScreen(withText: "ERROR synchronizing with server")
            } else {
                if let products = products {
                    let viewModel = self.viewModelBuilder.buildViewModel(withProducts: products)
                    self.view?.displayProductList(viewModel)
                    print("Products fetched from server")
                }
            }
        }
    }
    
    func loadNextPage() {
        
    }
}

// MARK: - Model Builder
class ProductListViewModelBuilder {
    func buildViewModel(withProducts products: [Product]) -> ProductListViewModel {
        let productsViewModel = products.compactMap(ProductViewModel.init)
        return ProductListViewModel(products: productsViewModel)
    }
}
