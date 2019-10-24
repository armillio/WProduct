//
//  ProductListDefaultPresenter.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 24/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import Foundation

struct ProductListViewModel {

}

// MARK: - Main Class
class ProductListDefaultPresenter: ProductListPresenter {
    private let interactorManager: ProductListInteractorManager
    private let router: ProductListRouter
    private weak var view: ProductListView?

    private let viewModelBuilder = ProductListViewModelBuilder()

    init(interactorManager: ProductListInteractorManager, router: ProductListRouter, view: ProductListView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - ProductListPresenter

}

// MARK: - Model Builder
class ProductListViewModelBuilder {
    func buildViewModel() -> ProductListViewModel {
        return ProductListViewModel()
    }
}