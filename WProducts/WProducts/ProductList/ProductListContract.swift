
import UIKit

protocol ProductListBuilder {
    func buildProductListModule() -> UIViewController?
}

protocol ProductListInteractorManager {

}

protocol ProductListPresenter {
    func loadData(fromRefresh refresh: Bool)
}

protocol ProductListView: class {

}

protocol ProductListRouter {

}
