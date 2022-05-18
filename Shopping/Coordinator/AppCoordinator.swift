//
//  AppCoordinator.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        let viewController = HomeViewController()
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func onComplete() {
        // TODO: Complete/Initiate Process here
    }
}
