
import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: ProductPresenter?
    var viewModel: ProductListViewModel?
    
    private var hasMoreData = true
    private var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureCollectionView()
        configureLayout()
        selectedProduct()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    // MARK: - Configuration
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.isPagingEnabled = true
        collectionView.registerNib(ProductDetailCollectionViewCell.self)
        collectionView.scrollsToTop = true
    }
    
    private func configureLayout() {
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        collectionView.itemSize(withView: view, withFlowLayout: flowLayout, withCount: viewModel?.products.count ?? 0)
    }
    
    // MARK: - Actions
    
    func loadData() {
        presenter?.loadData()
    }
    
    func selectedProduct(){
        DispatchQueue.main.async {
            if (self.indexPath != nil) {
                self.collectionView.scrollToItem(at: self.indexPath ?? IndexPath.init(row: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
}

// MARK: - ProductView

extension ProductViewController: ProductView {
    func displayActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func displayProduct(withViewModel viewModel: ProductListViewModel, withIndexPath indexPath: IndexPath) {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
        }
        self.viewModel = viewModel
        self.indexPath = indexPath
        self.collectionView.reloadData()
    }
    
    func displayPaginatedList(withViewModel viewModel: ProductListViewModel) {
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            self.viewModel = viewModel
            self.collectionView.reloadData()
        }
    }
    
    func updateNoMoreData() {
        DispatchQueue.main.async {
            self.hasMoreData = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func displayEmptyScreen(withText text: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.viewModel = nil
            self.showEmptyScreen()
        }
    }
    
    private func showEmptyScreen() {
        let contentView = UIView(frame: CGRect(x: collectionView.bounds.origin.x, y: collectionView.bounds.origin.y, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        let blankImage = UIImage.init(named: "product_detail")
        let detailImageView = UIImageView.init(frame: CGRect.zero)
        detailImageView.image = blankImage
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailImageView)

        let widthConstraint = NSLayoutConstraint(item: detailImageView, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: detailImageView, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        let xConstraint = NSLayoutConstraint(item: detailImageView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: detailImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
        
        collectionView.backgroundView = contentView
    }
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
    
    private func manageInfiniteScroll(forScroll scrollView: UIScrollView) {
        if self.scrollViewDidDragLeftFromSide(collectionView) && self.hasMoreData {
            self.presenter?.loadNextPage()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        
        let safeHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        var height = safeHeight
        if  safeHeight == 0 {
            height = view.frame.size.width
        }
        
        return CGSize(width: view.frame.size.width, height: height)
    }
}
