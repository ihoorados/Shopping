//
//  HomeViewController.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import UIKit

protocol HomeUserInterface: AnyObject {

    func start()
}

class HomeViewController: UIViewController {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    let viewModel: HomeViewModelImpl

    init(viewModel: HomeViewModelImpl) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.viewModel.homeUIDelegate = self
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Lifecycle
    /* ////////////////////////////////////////////////////////////////////// */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.startHomeSpace(host: self)
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: User InterFace Properties
    /* ////////////////////////////////////////////////////////////////////// */

    lazy var searchTextFeild: UITextField = {

        let textFeild = UITextField()
        return textFeild
    }()

}


/* ////////////////////////////////////////////////////////////////////// */
// MARK: Home User Interface
/* ////////////////////////////////////////////////////////////////////// */

extension HomeViewController: HomeUserInterface{

    func start() {

        print("✅ Start Home UI")
        self.view.backgroundColor = .systemBackground
    }
}
