
import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: ProductListPresenter?
    var viewModel: ProductListViewModel?
    
    private var hasMoreData = true
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadData(fromRefresh: true)
        tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "PRODUCTS"
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.loadData(fromRefresh: true)
    }
    
    // MARK: - Configuration
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
        tableView.addSubview(refreshControl)
    }
    
    private func registerNibs() {
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
    
    func displayEmptyScreen(withText text: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.viewModel = nil
            self.showEmptyMessage(withText: text)
        }
    }
    
    private func showEmptyMessage(withText text: String) {
        let contentView = UIView(frame: CGRect(x: tableView.bounds.origin.x, y: tableView.bounds.origin.y, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        
        let blankImage = UIImage.init(named: "offline")
        let detailImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        detailImageView.image = blankImage
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailImageView)

        let noResultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width - 32, height: 60))
        noResultLabel.text = text
        noResultLabel.adjustHeightOfLabel()
        noResultLabel.textColor = UIColor.darkGray
        noResultLabel.textAlignment = .center
        noResultLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noResultLabel)
        
        let widthConstraint = NSLayoutConstraint(item: detailImageView, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: detailImageView, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        let xConstraint = NSLayoutConstraint(item: detailImageView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: detailImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: -(noResultLabel.frame.height * 3))

        let widthLabelConstraint = NSLayoutConstraint(item: noResultLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.size.width - 32)
        let heightLabelConstraint = NSLayoutConstraint(item: noResultLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: noResultLabel.frame.size.height)
        let xLabelConstraint = NSLayoutConstraint(item: noResultLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
        let yLabelConstraint = NSLayoutConstraint(item: noResultLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint, widthLabelConstraint, heightLabelConstraint, xLabelConstraint, yLabelConstraint])
        tableView.separatorStyle = .none
        tableView.backgroundView = contentView
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
    
    private func manageInfiniteScroll(forScroll scrollView: UIScrollView) {
        if self.scrollViewDidDragDownFromBottom(tableView) && self.hasMoreData {
            self.presenter?.loadNextPage()
        }
    }
}
