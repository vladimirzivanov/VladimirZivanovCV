//
//  AppDelegate.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/1/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var applicationCoordinator: ApplicationCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupCoordinator()

        return true
    }
}

private extension AppDelegate {
    func setupCoordinator() {
        guard let window = self.window else {
            fatalError("UIWindow not initialized!")
        }

        let rootNavigationCoordinator = UINavigationController()
        self.applicationCoordinator = ApplicationCoordinator(window: window,
                                                             rootViewController: rootNavigationCoordinator)
        self.applicationCoordinator.start { }
    }
}

