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

        // Composition Root

        let loginVM = LoginViewModelImpl()
        let LoginVC = LoginViewController(viewModel: loginVM)

        navigationController.viewControllers = [LoginVC]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        loginVM.completionSignIn = {

            let viewModel = HomeViewModelImpl()
            let viewController = HomeViewController(viewModel: viewModel)
            self.navigationController.viewControllers = [viewController]
            self.window.rootViewController = self.navigationController
            self.window.makeKeyAndVisible()
        }


    }

    private func onComplete() {
        // TODO: Complete/Initiate Process here
    }
}
