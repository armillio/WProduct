
import UIKit

class ProductTableViewCell: UITableViewCell, UITableViewCellStaticProtocol {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var reviewRating: CosmosView!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellHeight(withProduct product: ProductViewModel?, withContentViewWidth contentWidth: CGFloat?) -> CGFloat? {
        guard let viewWidth = contentWidth else { return 0.0 }
        let contentViewWidth = viewWidth - (100.0 + 16.0 + 8.0 + 16.0)
        
        let label = UILabel.init()
        
        let productName = label.determineLabelHeight(withWidth: contentViewWidth, withFont: UIFont.preferredFont(forTextStyle: .footnote), withText: product?.name)
        
        let reviewCount = label.determineLabelHeight(withWidth: contentViewWidth, withFont: UIFont.preferredFont(forTextStyle: .caption2), withText: String.init(format: "%ld", product?.reviewCount ?? 9999.99))
        
        let productPrice = label.determineLabelHeight(withWidth: contentViewWidth, withFont: UIFont.preferredFont(forTextStyle: .title2), withText: product?.price)
        
        let padding:CGFloat = 24.0 + 8.0 + 8.0
        var calculatedHeight = productName + reviewCount + productPrice + padding
        
        if calculatedHeight < (100 + 16) {
            calculatedHeight = 116
        }
        return calculatedHeight  + 16.0 + 1
    }
    
    func configureCell(withProduct product: ProductViewModel){
        self.productName.text = product.name.trimmingCharacters(in: NSCharacterSet.whitespaces)
        self.productName.adjustHeightOfLabel()
        self.reviewCount.text = String.init(format: "(%d)", product.reviewCount ?? 0)
        self.productPrice.text = product.price
        self.reviewRating.rating = product.reviewRating ?? 0
        let urlString = String.init(format:"%@%@", ApplicationConstants.APIBaseURL, product.image ?? "/")
        let url = URL.init(string: urlString)
        if url?.verifyUrl(url: url) ?? false {
            if let imageURL = url {
                self.productImage.download(fromURL: imageURL)
            }
        }else{
            self.productImage.image = UIImage.init(named: "no_image")
        }

        if product.inStock == false {
            self.productName.textColor = UIColor.systemGray
            self.productPrice.textColor = UIColor.systemGray
        }else{
            self.productName.textColor = UIColor.init(named: "lightBlue")
            self.productPrice.textColor = UIColor.init(named: "lightBlue")
        }
    }
}
