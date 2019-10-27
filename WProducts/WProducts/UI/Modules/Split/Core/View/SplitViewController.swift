//
//  SplitViewController.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 26/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    var presenter: SplitPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        let list = UINavigationController()
        let detail = UINavigationController()
        
        guard let productViewController = self.productBuilder().buildProductModule(nil) else{ return }
        guard let productListViewController = self.productListBuilder().buildProductListModule() else{ return }
        
        list.viewControllers = [productListViewController]
        detail.viewControllers = [productViewController]
        
        self.viewControllers = [list, detail]
    }
    
        func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
    //
    //        guard let productViewController = self.productBuilder().buildProductModule(nil) else{ return false }
    //        guard let productListViewController = self.productListBuilder().buildProductListModule() else{ return false }
    //
    //        if let nc = secondaryViewController as? UINavigationController {
    //            if let topVc = nc.topViewController {
    //                if let dc = topVc as? productViewController {
    //                    let hasDetail = Thing.noThing !== dc.thing
    //                    return !hasDetail
    //                }
    //            }
    //        }
            return true
        }
    
    fileprivate func productBuilder() -> ProductBuilder {
        return Container.shared.productBuilder()
    }
    
    fileprivate func productListBuilder() -> ProductListBuilder {
        return Container.shared.productListBuilder()
    }
}

// MARK: - SplitView
extension SplitViewController: SplitView {
    
}
