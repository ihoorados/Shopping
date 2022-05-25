//
//  LogingViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 22/5/2022.
//

import Foundation

protocol LoginViewModel {

    func authenticatedWith(userName: String, passWord: String)
}

class LoginViewModelImpl: LoginViewModel {

    var completionSignIn: (()->())?
    let storage = Storage.shared

    func authenticatedWith(userName: String, passWord: String){

        self.saveUserToStorage(user: User(userName: userName, passWord: passWord))
        self.completionSignIn?()
    }

    fileprivate func saveUserToStorage(user: User){

        storage.isAuthenticated = true
    }
}
