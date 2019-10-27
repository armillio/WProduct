//
//  SplitDefaultPresenter.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 26/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import Foundation

struct SplitViewModel {

}

// MARK: - Main Class
class SplitDefaultPresenter: SplitPresenter {
    private let interactorManager: SplitInteractorManager
    private let router: SplitRouter
    private weak var view: SplitView?

    private let viewModelBuilder = SplitViewModelBuilder()

    init(interactorManager: SplitInteractorManager, router: SplitRouter, view: SplitView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - SplitPresenter

}

// MARK: - Model Builder
class SplitViewModelBuilder {
    func buildViewModel() -> SplitViewModel {
        return SplitViewModel()
    }
}