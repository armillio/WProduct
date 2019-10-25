
import UIKit

class ProductCollectionViewCell: UICollectionViewCell, UICollectionViewCellStaticProtocol {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var productPrice: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellHeight(withProduct product: ProductViewModel?, withContentViewWidth contentWidth: CGFloat?) -> CGFloat? {
        guard let viewWidth = contentWidth else { return 0.0 }
        let contentViewWidth = viewWidth - (100.0 + 16.0 + 8.0 + 16.0)
        
        let productName = self.productName.determineLabelHeight(withWidth: contentViewWidth, withFont: UIFont.preferredFont(forTextStyle: .body), withText: product?.name)
        
        let reviewCount = self.reviewCount.determineLabelHeight(withWidth: contentViewWidth, withFont: UIFont.preferredFont(forTextStyle: .caption2), withText: String.init(format: "%d", product?.reviewCount ?? 9999.99))
        
        let productPrice = self.productPrice.determineLabelHeight(withWidth: contentViewWidth, withFont: UIFont.preferredFont(forTextStyle: .footnote), withText: product?.price)
        
        let padding:CGFloat = 16.0 + 8.0 + 8.0
        var calculatedHeight = productName + reviewCount + productPrice + padding
        
        if calculatedHeight < 100 {
            calculatedHeight = 100
        }
        
        return calculatedHeight  + 16.0
    }
    
    func configureCell(withProduct product: ProductViewModel){
        self.productName.text = product.name
        self.reviewCount.text = String.init(format: "%d", product.reviewCount)
        self.productPrice.text = product.price
        self.reviewRating.text = String.init(format: "%d", product.reviewRating)
        let url = URL.init(string: String.init(format:"%@%@", ApplicationConstants.APIBaseURL, product.image ?? "/"))

        if let imageURL = url {
            self.productImage.download(fromURL: imageURL)
        }
    }
}
