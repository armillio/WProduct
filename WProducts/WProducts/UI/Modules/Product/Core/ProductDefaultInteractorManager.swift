
import Foundation

class ProductDefaultInteractorManager: ProductInteractorManager {
    private let walmartHTTPRequest = WalmartHTTPRequestDefault()
    
    func getProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ products: [Product]?, _ error: Error?) -> Void) {
        walmartHTTPRequest.fetchProductListData(withPage: page, pageSize: pageSize) { (result, error) in
            if result {
                completion(ProductsManager.shared.fetchProducts(), nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
