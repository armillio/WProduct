
import Foundation

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
    private var product: ProductViewModel? = nil
    
    init(interactorManager: ProductInteractorManager, router: ProductRouter, view: ProductView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
        CurrentPageCoordinator.shared.addDelegate(self)
    }
    
    deinit {
        CurrentPageCoordinator.shared.removeDelegate(self)
    }
    
    // MARK: - ProductPresenter
    
    func loadData() {
        let data = interactorManager.getProducts()
        if data.products != nil {
            guard let products = data.products else{ return }
            let viewModel = self.viewModelBuilder.buildViewModel(withProducts: products)
            self.viewModel = viewModel
            guard let indexPath = data.indexPath else{ return }
            self.view?.displayProduct(withViewModel: viewModel, withIndexPath: indexPath)
        }else{
            self.view?.displayEmptyScreen(withText: "Select a product from the list")
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
}

extension ProductDefaultPresenter: CurrentPageCoordinatorDelegate{
    func getCurrentPage(withPage currentPage: Int) {
        self.currentPage = currentPage
    }
}
