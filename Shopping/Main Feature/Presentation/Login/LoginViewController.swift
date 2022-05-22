//
//  LoginViewController.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 22/5/2022.
//

import UIKit

class LoginViewController: UIViewController {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    let viewModel: LoginViewModelImpl

    init(viewModel: LoginViewModelImpl) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Lifecycle
    /* ////////////////////////////////////////////////////////////////////// */

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUIEvent()
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: User InterFace Properties
    /* ////////////////////////////////////////////////////////////////////// */

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameTextFeild: UIButton!
    @IBOutlet weak var passWordTextFeild: UIButton!

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Function
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func setupUIEvent(){

        self.signInButton.addTarget(self, action: #selector(self.signInButtonAction), for: .touchUpInside)
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: UIEvent
    /* ////////////////////////////////////////////////////////////////////// */


    @objc func signInButtonAction(){

        self.viewModel.completionSignIn?()
    }

}
