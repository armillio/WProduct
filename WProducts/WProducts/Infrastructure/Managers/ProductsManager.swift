
import Foundation

class ProductsManager {
    static let shared = ProductsManager()
    private var allProducts: [Product]?
    
    private init(){}
    
    func fetchProducts() -> [Product]?{
        return self.allProducts
    }
    
    func addProducts(products: [Product]){
        guard let productsArray = self.allProducts else{
            replaceProducts(withProducts: products)
            return
        }
        
        var allProducts = productsArray
        for product in products {
            var inTheCache = false
            for  originalProduct in productsArray{
                if product.name == "" || product.id == "" {
                    inTheCache = true
                    allProducts.removeAll{$0.id == product.id}
                    allProducts.removeAll{$0.id == ""}
                }else if product.id == originalProduct.id {
                    inTheCache = true
                }
            }
            if !inTheCache {
                allProducts.append(product)
            }
        }
        self.allProducts = allProducts
    }
    
    func replaceProducts(withProducts products: [Product]){
        self.allProducts = products
    }
}
