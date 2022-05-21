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


        // filterCategories
        var filterCategories: [Categories] = []
        if let data = UserDefaults.standard.object(forKey: "filterCategories") as? Data{

            if let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Categories]{

                filterCategories = value
            }
        }
        self.filterCategories = filterCategories
    }

    private(set) var filterCategories: [Categories]{

        didSet{

            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.filterCategories)
            UserDefaults.standard.set(encodedData, forKey: "filterCategories")
            UserDefaults.standard.synchronize()
        }
    }

}
