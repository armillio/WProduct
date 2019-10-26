
import Foundation

protocol WalmartHTTPRequest {
    func fetchProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ response: [Product]?, _ error: Error?) -> Void)
}

final class WalmartHTTPRequestDefault: WalmartHTTPRequest {
    
    func fetchProductListData(withPage page: Int, pageSize: Int = 20, completion: @escaping (_ response: [Product]?, _ error: Error?) -> Void){
        let walmartURL = ApplicationConstants.APIBaseURL + "/walmartproducts/\(page)/\(pageSize)"
        guard let url = URL(string: walmartURL) else { return  }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data,
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let results = jsonObject["products"] as? [[String: AnyObject]] {

                    var products = Array<Product>()
                    for product in results {
                        guard let productId = product["productId"] as? String,
                            let name: String = product["productName"] as? String
                            else{ return completion(nil, error) }
                        
                        let shortDescription:String? = product["shortDescription"] as? String ?? ""
                        let longDescription:String? = product["longDescription"] as? String ?? ""
                        let price:String? = product["price"] as? String ?? ""
                        let image:String? = product["productImage"] as? String ?? ""
                        let reviewRating:Double? = product["reviewRating"] as? Double ?? 0
                        let reviewCount:Int? = product["reviewCount"] as? Int ?? 0
                        let inStock:Bool = (product["inStock"] != nil)
                        products.append(Product.init(id: productId, name: name, shortDescription: shortDescription, longDescription: longDescription, price: price, image: image, reviewRating: reviewRating, reviewCount: reviewCount, inStock: inStock, page: page))
                    }
                    completion(products, nil)
                } else {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
