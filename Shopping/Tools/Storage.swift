//
//  Storage.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 21/5/2022.
//

import Foundation

class Storage{

    // MARK: Static
    static let shared: Storage = Storage()

    // MARK: Private Init
    private init(){


        // is Authenticated User
        var isAuthenticated: Bool = false
        if let value = UserDefaults.standard.object(forKey: "isAuthenticated") as? Bool{

            isAuthenticated = value
        }
        self.isAuthenticated = isAuthenticated
    }

    var isAuthenticated: Bool{

        didSet{

            UserDefaults.standard.set(self.isAuthenticated, forKey: "isAuthenticated")
            UserDefaults.standard.synchronize()
        }
    }

}
