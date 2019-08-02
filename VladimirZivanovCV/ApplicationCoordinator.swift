//
//  ApplicationCoordinator.swift
//  VladimirZivanovCV
//
//  Created by Vladimir Zivanov on 8/1/19.
//  Copyright © 2019 Vladimir Zivanov. All rights reserved.
//

import UIKit
import Coordinator

final class ApplicationCoordinator: NavigationCoordinator {
    var window: UIWindow

    init(window: UIWindow, rootViewController: UINavigationController?) {
        self.window = window
        super.init(rootViewController: rootViewController)

        self.window.rootViewController = rootViewController
    }

    override func start(with completion: @escaping () -> Void) {
        self.setRoot()

        super.start(with: completion)
    }
}

private extension ApplicationCoordinator {
    func setRoot() {
        self.setHomeAsRoot()
    }

    func setHomeAsRoot() {
        let service = CVService()
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController.makeFromStoryboard()
        viewController.viewModel = viewModel

        self.root(viewController)
    }
}
