
import UIKit

protocol ProductBuilder {
    func buildProductModule(_ product: ProductViewModel?) -> UIViewController?
}

protocol ProductInteractorManager {
    func getProductListData(withPage page: Int, pageSize: Int, completion: @escaping (_ response: [Product]?, _ error: Error?) -> Void)
    func getProducts() -> (products: [Product]?, indexPath: IndexPath?)
}

protocol ProductPresenter {
    func loadData()
    func loadNextPage()
}

protocol ProductView: class {
    func displayActivityIndicator()
    func displayProduct(withViewModel viewModel: ProductListViewModel, withIndexPath indexPath: IndexPath)
    func displayPaginatedList(withViewModel viewModel: ProductListViewModel)
    func updateNoMoreData()
    func displayEmptyScreen(withText text: String)
}

protocol ProductRouter {

}
