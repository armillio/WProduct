
import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell, UICollectionViewCellStaticProtocol {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var reviewRating: CosmosView!
    @IBOutlet weak var productPrice: UILabel!
    
    var productDetail: ProductViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let product = self.productDetail else{ return }
        self.productName.text = product.name.trimmingCharacters(in: NSCharacterSet.whitespaces)
        self.productName.adjustHeightOfLabel()
        self.reviewCount.text = String.init(format: "(%d)", product.reviewCount ?? 0)
        self.productPrice.text = product.price
        self.reviewRating.rating = product.reviewRating ?? 0
        let url = URL.init(string: String.init(format:"%@%@", ApplicationConstants.APIBaseURL, product.image ?? "/"))
        if let imageURL = url {
            self.productImage.download(fromURL: imageURL)
        }
        self.productDescription.text = product.shortDescription?.htmlToString
        self.productName.adjustHeightOfLabel()
    }
}
