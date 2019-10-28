
import Foundation

// Model

struct Product:Hashable {
    let id: String
    let name: String
    let shortDescription: String?
    let longDescription: String?
    let price: String?
    let image: String?
    let reviewRating: Double?
    let reviewCount: Int?
    let inStock: Bool
    let page: Int
}

struct ProductViewModel {
    let id: String
    let name: String
    let shortDescription: String?
    let longDescription: String?
    let price: String?
    let image: String?
    let reviewRating: Double?
    let reviewCount: Int?
    let inStock: Bool
    let page: Int
    
    init(product: Product) {
        self.id = product.id
        self.name = product.name
        self.shortDescription = product.shortDescription
        self.longDescription = product.longDescription
        self.price = product.price
        self.image = product.image
        self.reviewRating = product.reviewRating
        self.reviewCount = product.reviewCount
        self.inStock = product.inStock
        self.page = product.page
    }
}

// MARK: - Main Class
class ProductDefaultPresenter: ProductPresenter {
    private let interactorManager: ProductInteractorManager
    private let router: ProductRouter
    private weak var view: ProductView?
    
    private let viewModelBuilder = ProductListViewModelBuilder()
    private var viewModel: ProductListViewModel?
    
    private var currentPage = 1
    private var nextPageIsLoading = false
    
    init(interactorManager: ProductInteractorManager, router: ProductRouter, view: ProductView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
        ProductListCoordinator.shared.addDelegate(self)
    }
    
    deinit {
        ProductListCoordinator.shared.removeDelegate(self)
    }
    
    // MARK: - ProductPresenter
    
    func loadNextPage() {
        if !self.nextPageIsLoading {
            self.nextPageIsLoading = true
            
            self.currentPage += 1
            interactorManager.getProductListData(withPage: self.currentPage, pageSize: 30) { (products, error) in
                if let products = products {
                    ProductsManager.shared.addProducts(products: products)
                    let viewModel = self.viewModelBuilder.buildViewModel(withProducts: ProductsManager.shared.fetchProducts() ?? products)
                    self.viewModel = viewModel
                    guard let _viewModel = self.viewModel else { return }
                    self.view?.displayPaginatedList(withViewModel: _viewModel)
                    self.nextPageIsLoading = false
                } else {
                    self.view?.updateNoMoreData()
                    self.nextPageIsLoading = false
                }
            }
        }
    }
}

extension ProductDefaultPresenter: ProductListCoordinatorDelegate{
    func getCurrentPage(withPage currentPage: Int) {
        self.currentPage = currentPage
    }
}
