
import Foundation

struct ProductList: Codable {
    var products: [Product]
}

struct Product:Codable {
    let id: String
    let name: String
    let shortDescription: String?
    let longDescription: String?
    let price: String?
    let image: String?
    let reviewRating: Double?
    let reviewCount: Int?
    let inStock: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "productId"
        case name = "productName"
        case shortDescription
        case longDescription
        case price
        case image = "productImage"
        case reviewRating
        case reviewCount
        case inStock
    }
}
