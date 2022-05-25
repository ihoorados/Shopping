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

    let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {

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
    @IBOutlet weak var userNameTextFeild: UITextField!
    @IBOutlet weak var passWordTextFeild: UITextField!

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

        guard let userName = self.userNameTextFeild.text else {

            // Show Error
            return
        }

        guard let passWord = self.passWordTextFeild.text else {

            // Show Error
            return
        }
        self.viewModel.authenticatedWith(userName: userName, passWord: passWord)
    }

}
