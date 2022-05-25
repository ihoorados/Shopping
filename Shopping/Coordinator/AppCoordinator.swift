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

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    private let window: UIWindow
    private let navigationController: UINavigationController
    private let storage = Storage.shared

    init(window: UIWindow) {

        self.window = window
        self.navigationController = UINavigationController()
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Function
    /* ////////////////////////////////////////////////////////////////////// */

    func start() {

        // Composition Root
        if storage.isAuthenticated{
            self.openHomeView()
        }else{
            self.openAthenticationView()
        }
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Functions
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func openAthenticationView(){

        let loginVM = LoginViewModelImpl()
        let LoginVC = LoginViewController(viewModel: loginVM)
        loginVM.completionSignIn = {

            self.openHomeView()
        }
        navigationController.viewControllers = [LoginVC]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    fileprivate func openHomeView(){

        let viewModel = HomeViewModelImpl()
        let viewController = HomeViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [viewController]
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }

}
