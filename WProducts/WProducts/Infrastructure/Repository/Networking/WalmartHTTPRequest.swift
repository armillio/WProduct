
import UIKit

protocol WalmartHTTPRequest {
    func fetchProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ response: Bool, _ error: Error?) -> Void)
    func fetchMockData(withPage page: Int, pageSize: Int, completion: @escaping (_ response: Bool, _ error: Error?) -> Void)
}

final class WalmartHTTPRequestDefault: WalmartHTTPRequest {
    
    func fetchProductListData(withPage page: Int, pageSize: Int = 20, completion: @escaping (_ response: Bool, _ error: Error?) -> Void){
        let walmartURL = ApplicationConstants.APIBaseURL + "/walmartproducts/\(page)/\(pageSize)"
        guard let url = URL(string: walmartURL) else { return  }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let productList = try decoder.decode(ProductList.self, from: data)
                    ProductsManager.shared.addProducts(products: productList.products)
                    completion(true, nil)
                } catch let err {
                    completion(false, err)
                }
            } else {
                completion(false, error)
            }
            
        }.resume()
    }
    
    func fetchMockData(withPage page: Int, pageSize: Int = 20, completion: @escaping (_ response: Bool, _ error: Error?) -> Void){
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let productList = try decoder.decode(ProductList.self, from: data)
                ProductsManager.shared.addProducts(products: productList.products)
                completion(true, nil)
            } catch let err {
                completion(false, err)
            }
        }
    }
}
