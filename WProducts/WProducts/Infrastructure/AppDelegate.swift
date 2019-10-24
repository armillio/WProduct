//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Armando Carmona on 24/10/2019.
//  Copyright (c) 2016, Happy Computer. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //setUpLogger() // TODO: logger
        loadThirdPartyStuff()

        self.window = Container.sharedContainer.inject(withIsLoggedIn: true) // TODO: check if is loggedIn
        self.window!.backgroundColor = UIColor.white
        configureTabBarAppearance()
        self.window!.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


    // MARK: Configure
    func loadThirdPartyStuff() {
        #if NDEBUG
        Fabric.sharedSDK().debug = true
        Fabric.with([Crashlytics.self])
        #endif
    }
}