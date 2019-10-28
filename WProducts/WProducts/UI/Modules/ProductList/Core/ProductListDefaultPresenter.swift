
import Foundation

struct ProductListViewModel {
    var products: [ProductViewModel]
}

// MARK: - Main Class
class ProductListDefaultPresenter: ProductListPresenter {
    private let interactorManager: ProductListInteractorManager
    private let router: ProductListRouter
    private weak var view: ProductListView?
    
    private var viewModelBuilder = ProductListViewModelBuilder()
    private var viewModel: ProductListViewModel?
    
    var currentPage = 1
    private var nextPageIsLoading = false
    
    init(interactorManager: ProductListInteractorManager, router: ProductListRouter, view: ProductListView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }
    
    // MARK: - ProductListPresenter
    
    func loadData(fromRefresh refresh: Bool) {
        if !refresh {
            self.view?.displayActivityIndicator()
        }
        interactorManager.getProductListData(withPage: 1, pageSize: 20) { (products, error) in
            self.view?.displayEmptyScreen(withText: "ERROR synchronizing with server")
//            if error != nil {
//                self.view?.displayEmptyScreen(withText: "ERROR synchronizing with server")
//            } else {
//                self.currentPage = 1
//                if let products = products {
//                    let viewModel = self.viewModelBuilder.buildViewModel(withProducts: products)
//                    self.viewModel = viewModel
//                    self.view?.displayProductList(viewModel)
//                }
//            }
        }
    }
    
    func loadNextPage() {
        if !self.nextPageIsLoading {
            self.nextPageIsLoading = true
            self.currentPage += 1
            interactorManager.getProductListData(withPage: self.currentPage, pageSize: 20) { (products, error) in
                if let products = products {
                    let viewModel = self.viewModelBuilder.buildViewModel(withProducts: products)
                    self.viewModel = viewModel
                    self.view?.displayPaginatedList(withViewModel: viewModel)
                    self.nextPageIsLoading = false
                } else {
                    self.view?.updateNoMoreData()
                    self.nextPageIsLoading = false
                }
            }
        }
    }
    
    func showProductDetail(withProduct product: ProductViewModel){
        router.navigateToProductDetail(withProduct: product)
    }
}

// MARK: - Model Builder

class ProductListViewModelBuilder {
    func buildViewModel(withProducts products: [Product]) -> ProductListViewModel {
        let productsViewModel = products.compactMap(ProductViewModel.init)
        return ProductListViewModel(products: productsViewModel)
    }
}
