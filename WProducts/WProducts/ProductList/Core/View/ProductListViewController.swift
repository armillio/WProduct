//
//  ProductListViewController.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 24/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - ProductListView
extension ProductListViewController: ProductListView {

}