
import Foundation

class ProductDefaultInteractorManager: ProductInteractorManager {
    private let walmartHTTPRequest = WalmartHTTPRequestDefault()
    var product: ProductViewModel?
    
    init(_ product: ProductViewModel? = nil) {
        self.product = product
    }
    
    func getProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ products: [Product]?, _ error: Error?) -> Void) {
        walmartHTTPRequest.fetchProductListData(withPage: page, pageSize: pageSize) { (result, error) in
            if result {
                completion(ProductsManager.shared.fetchProducts(), nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getProducts() -> (products: [Product]?, indexPath: IndexPath?) {
        let products = ProductsManager.shared.fetchProducts()
        guard let indexPath = products?.firstIndex(where: {
            $0.id == self.product?.id
        }).flatMap({
            IndexPath(row: $0, section: 0)
        }) else { return (products, nil) }
        return (products, indexPath)
    }
}
