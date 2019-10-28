
import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell, UICollectionViewCellStaticProtocol {
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productLongDescription: UITextView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var reviewRating: CosmosView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productLongDescriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productShortDescriptionHeightConstraint: NSLayoutConstraint!
    
    var productDetail: ProductViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(){
        guard let product = self.productDetail else{ return }
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
        
        self.productDescription.attributedText = product.shortDescription?.html
        self.productDescription.adjustHeightOfLabel()
        var frameShortHeight = self.productDescription.frame.size.height
        if frameShortHeight < 20 {
            frameShortHeight = 20
        }
        self.productShortDescriptionHeightConstraint.constant = frameShortHeight
        
        self.productLongDescription.attributedText = product.longDescription?.html
        self.productLongDescription.isScrollEnabled = false
        self.productLongDescription.sizeToFit()
        var frameLongHeight = self.productLongDescription.frame.size.height
        if frameLongHeight < 20 {
            frameLongHeight = 20
        }
        self.productLongDescriptionHeightConstraint.constant = frameLongHeight
    }
}
