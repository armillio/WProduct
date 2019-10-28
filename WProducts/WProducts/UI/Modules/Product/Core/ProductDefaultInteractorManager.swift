
import Foundation

class ProductDefaultInteractorManager: ProductInteractorManager {
    private let walmartHTTPRequest = WalmartHTTPRequestDefault()
    
    func getProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ products: [Product]?, _ error: Error?) -> Void) {
        walmartHTTPRequest.fetchProductListData(withPage: page, pageSize: pageSize) { (products, error) in
            if let products = products, products.count > 0 {
                completion(products, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
