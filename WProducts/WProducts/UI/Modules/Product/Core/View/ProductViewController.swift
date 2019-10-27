
import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var presenter: ProductPresenter?
    
    private var viewModelBuilder = ProductListViewModelBuilder()
    
    var viewModel: ProductListViewModel?
    var product: ProductViewModel?
    var indexPath: IndexPath?
    var isViewDidLayoutCallFirstTime:Bool = true
    
    fileprivate var hasMoreData = true
    
    convenience init(_ product: ProductViewModel? = nil) {
        self.init(nibName: nil, bundle: nil)
        self.product = product
        guard let products = ProductsManager.shared.fetchProducts() else{ return }
        let viewModel = self.viewModelBuilder.buildViewModel(withProducts: products)
        self.viewModel = viewModel
        
        
        guard let indexPath = products.firstIndex(where: {
            $0.id == product?.id
        }).flatMap({
            IndexPath(row: $0, section: 0)
        }) else { return }
        self.indexPath = indexPath
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
        configureLayout()
        
        DispatchQueue.main.async {
            guard let indexPath = self.indexPath else{ return }
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: - Configuration
    
    fileprivate func configureNavigationBar() {
        navigationItem.title = self.product?.name
    }
    
    fileprivate func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.isPagingEnabled = true
        collectionView.registerNib(ProductDetailCollectionViewCell.self)
        collectionView.scrollsToTop = true
    }
    
    fileprivate func configureLayout() {
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        collectionView.itemSize(withView: view, withFlowLayout: flowLayout, withCount: viewModel?.products.count ?? 0)
    }
}

// MARK: - ProductView

extension ProductViewController: ProductView {
    
}

// MARK: - UICollectionViewDataSource

extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.cellIdentifier(), for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductDetailCollectionViewCell, let product = viewModel?.products[indexPath.row] else { return }
        cell.productDetail = product
        cell.configureCell()
        cell.detailScrollView.scrollsToTop = true
        cell.detailScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.manageInfiniteScroll(forScroll: scrollView)
    }
    
    fileprivate func manageInfiniteScroll(forScroll scrollView: UIScrollView) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        
        let safeWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        var width = safeWidth
        if  safeWidth == 0 {
            width = view.frame.size.width
        }
        
        let safeHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        var height = safeHeight
        if  safeHeight == 0 {
            height = view.frame.size.width
        }
        
        return CGSize(width: view.frame.size.width, height: height)
    }
}
