
import UIKit

protocol ProductBuilder {
    func buildProductModule(_ product: ProductViewModel?) -> UIViewController?
}

protocol ProductInteractorManager {
    func getProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ response: [Product]?, _ error: Error?) -> Void)
}

protocol ProductPresenter {
    func loadNextPage()
}

protocol ProductView: class {
    func displayActivityIndicator()
    func displayPaginatedList(withViewModel viewModel: ProductListViewModel)
    func updateNoMoreData()
}

protocol ProductRouter {

}
