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


        // User
        var user: User? = nil
        if let data = UserDefaults.standard.object(forKey: "user") as? Data{

            if let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? User{

                user = value
            }
        }
        self.user = user
    }

    var user: User?{

        didSet{

            if let user = self.user{

                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
                UserDefaults.standard.set(encodedData, forKey: "user")
            }else{

                UserDefaults.standard.removeObject(forKey: "user")
            }

            UserDefaults.standard.synchronize()
        }
    }

}
