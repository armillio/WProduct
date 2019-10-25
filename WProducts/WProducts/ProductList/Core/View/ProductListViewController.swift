
import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var presenter: ProductListPresenter?
    var viewModel: ProductListViewModel?

    lazy var baseCellController = BaseCellController()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    fileprivate func configureNavigationBar() {
        navigationItem.title = "PRODUCTS"
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.loadData(fromRefresh: true)
    }
    
    // MARK: - Configuration
    
    fileprivate func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.registerNib(ProductCollectionViewCell.self)
        collectionView.addSubview(refreshControl)
    }
    
    fileprivate func configureLayout() {
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        collectionView.itemSize(withView: view, withFlowLayout: flowLayout, withCount: viewModel?.products.count ?? 0)
    }
}

// MARK: - ProductListView

extension ProductListViewController: ProductListView {

}

// MARK: - UICollectionViewDataSource

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier(), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductCollectionViewCell, let product = viewModel?.products[indexPath.row] else { return }
        cell.configureCell(withProduct: product)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        
        let safeWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        var width = safeWidth
        
        if  safeWidth == 0 {
            width = view.frame.size.width
        }
        
        let newWidth = collectionView.widthOfCell(withSafeArea: width, withList: viewModel?.products.count)
        let product = viewModel?.products[indexPath.row]
        let collectionViewCell = ProductCollectionViewCell()
        guard let height = collectionViewCell.cellHeight(withProduct: product, withContentViewWidth: newWidth) else{ return CGSize(width: newWidth, height: 100) }
        
        return CGSize(width: newWidth, height: height)
    }
}
