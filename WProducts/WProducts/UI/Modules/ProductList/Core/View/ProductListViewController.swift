
import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var presenter: ProductListPresenter?
    var viewModel: ProductListViewModel?
    
    fileprivate var hasMoreData = true

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayActivityIndicator()
        configureNavigationBar()
        configureCollectionView()
        configureLayout()
        presenter?.loadData(fromRefresh: true)
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
    func displayActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func displayProductList(_ viewModel: ProductListViewModel) {
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.viewModel = viewModel
            self.collectionView.reloadData()
            self.collectionView.scrollsToTop = true
            self.hasMoreData = true
        }
    }
    
    func displayPaginatedList(withViewModel viewModel: ProductListViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.collectionView.reloadData()
        }
    }
    
    func updateNoMoreData() {
        DispatchQueue.main.async {
            self.hasMoreData = false
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
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
        guard let product = self.viewModel?.products[indexPath.row] else { return }
        presenter?.showProductDetail(withProduct: product)
    }
}

// MARK: - UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductCollectionViewCell, let product = viewModel?.products[indexPath.row] else { return }
        cell.configureCell(withProduct: product)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.manageInfiniteScroll(forScroll: scrollView)
    }
    
    fileprivate func manageInfiniteScroll(forScroll scrollView: UIScrollView) {
        if self.scrollViewDidDragDownFromBottom(collectionView) && self.hasMoreData {
            self.presenter?.loadNextPage()
        }
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
        
        var newWidth = collectionView.widthOfCell(withSafeArea: width, withList: viewModel?.products.count)

        //if splitViewController?.isCollapsed == true {
            newWidth = view.frame.size.width
        //}

        let product = viewModel?.products[indexPath.row]
        let collectionViewCell = ProductCollectionViewCell()
        guard let height = collectionViewCell.cellHeight(withProduct: product, withContentViewWidth: newWidth) else{ return CGSize(width: newWidth, height: 100) }
        
        return CGSize(width: newWidth, height: height)
    }
}
