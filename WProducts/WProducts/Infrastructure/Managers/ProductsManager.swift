
import Foundation

class ProductsManager {
    static let shared = ProductsManager()
    private var allProducts: [Product]?
    
    private init(){}
    
    func fetchProducts() -> [Product]?{
        return self.allProducts
    }
    
    func addProducts(products: [Product]){
        guard var productsArray = self.allProducts else{
            //var newProducts = products
            //newProducts.sort { $0.name < $1.name }
            replaceProducts(withProducts: products)
            return
        }
        let original = Set(productsArray), new = Set(products)
        productsArray = Array(original.union(new))
        //productsArray.sort { $0.name < $1.name }
        self.allProducts = productsArray
    }
    
    func replaceProducts(withProducts products: [Product]){
        self.allProducts = products
    }
}

/*
 ProductsManager.shared.fetchProducts()
 ProductsManager.shared.addProducts(products: )
 ProductsManager.shared.replaceProducts(withProducts: )
 */
