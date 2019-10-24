//
//  Container.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 24/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import UIKit

class Container {
    static let sharedContainer = Container()

    var tourViewController: UIViewController?
    var mainRootViewController: UIViewController?
}

// MARK: - AppDelegate Injection
extension Container {
    func inject(withIsLoggedIn isLoggedIn: Bool) -> UIWindow? {
        guard let window = window(isLoggedIn) else { return nil }
        return window
    }

    func window(_ isLoggedIn: Bool) -> UIWindow? {
        let window = UIWindow(frame: self.screen().bounds)
        if isLoggedIn {
            guard let rootVC = createMainRootViewController() else { return nil }
            window.rootViewController = rootVC
            return window
        } else {
            guard let rootVC = createTourRootViewController() else { return nil }
            window.rootViewController = rootVC
            return window
        }
    }

    func screen() -> UIScreen {
        return UIScreen.main
    }

    func createTourRootViewController() -> UIViewController? {
        // TODO: create and inject tourViewController if needed
        return nil
    }

    func createMainRootViewController() -> UIViewController? {
        // TODO: create and inject viewControllers
        return nil
    }
}

// MARK: - Builders Injection
extension Container {
    // TODO: remove if needed
    func tourBuilder() -> TourBuilder {
        return TourDefaultBuilder()
    }

    func productListBuilder() -> ProductListBuilder {
        return ProductListDefaultBuilder()
    }

    func productBuilder() -> ProductBuilder {
        return ProductDefaultBuilder()
    }

}