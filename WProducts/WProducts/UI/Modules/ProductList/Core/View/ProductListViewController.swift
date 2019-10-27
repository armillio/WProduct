
import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: ProductListPresenter?
    var viewModel: ProductListViewModel?
    
    fileprivate var hasMoreData = true
    
    lazy var productTableViewCell = ProductTableViewCell()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayActivityIndicator()
        configureNavigationBar()
        configureTableView()
        presenter?.loadData(fromRefresh: true)
    }
    
    fileprivate func configureNavigationBar() {
        navigationItem.title = "PRODUCTS"
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.loadData(fromRefresh: true)
    }
    
    // MARK: - Configuration
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
    }
    
    fileprivate func registerNibs() {
        tableView.registerNib(ProductTableViewCell.self)
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
            self.tableView.reloadData()
            self.tableView.scrollsToTop = true
            self.hasMoreData = true
        }
    }
    
    func displayPaginatedList(withViewModel viewModel: ProductListViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.tableView.reloadData()
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

// MARK: - UITableViewDataSource

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellIdentifier(), for: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ProductTableViewCell, let product = viewModel?.products[indexPath.row] else { return }
        cell.configureCell(withProduct: product)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let product = viewModel?.products[indexPath.row] else { return 0.0 }
        return productTableViewCell.cellHeight(withProduct: product, withContentViewWidth: self.view.bounds.width) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = self.viewModel?.products[indexPath.row] else { return }
        presenter?.showProductDetail(withProduct: product)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.manageInfiniteScroll(forScroll: scrollView)
    }
    
    fileprivate func manageInfiniteScroll(forScroll scrollView: UIScrollView) {
        if self.scrollViewDidDragDownFromBottom(tableView) && self.hasMoreData {
            self.presenter?.loadNextPage()
        }
    }
}
