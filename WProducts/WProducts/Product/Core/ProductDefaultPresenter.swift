
import Foundation

// Model

struct Product {
    let id: String
    let name: String
    let shortDescription: String?
    let longDescription: String?
    let price: String?
    let image: String?
    let reviewRating: Double?
    let reviewCount: Int?
    let inStock: Bool
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
    func buildViewModel(withProduct product: Product) -> ProductViewModel {
        return ProductViewModel(product: product)
    }
}
