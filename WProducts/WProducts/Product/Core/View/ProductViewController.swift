
import UIKit

class ProductViewController: UIViewController {
    var presenter: ProductPresenter?
    
    var product: ProductViewModel?
    
    convenience init(withProduct product: ProductViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.product = product
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - ProductView
extension ProductViewController: ProductView {
    
}
