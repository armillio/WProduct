
import UIKit

protocol ProductListBuilder {
    func buildProductListModule() -> UIViewController?
}

protocol ProductListInteractorManager {
    func getProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ response: [Product]?, _ error: Error?) -> Void)
}

protocol ProductListPresenter {
    func loadData(fromRefresh refresh: Bool)
    func loadNextPage()
}

protocol ProductListView: class {
    func displayActivityIndicator()
    func displayProductList(_ viewModel: ProductListViewModel)
}

protocol ProductListRouter {
    func navigateToProductDetail(withProduct product: ProductViewModel)
}
