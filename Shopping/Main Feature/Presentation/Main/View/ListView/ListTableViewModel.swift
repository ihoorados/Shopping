//
//  ListTableViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import UIKit

class ListTableViewModel: BaseViewModel {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    var model: ListModel

    init(model: ListModel) {

        self.model = model

        super.init()
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Observable Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var name: Dynamic<String> = Dynamic<String>("")
    var price: Dynamic<String> = Dynamic<String>("")
    var category: Dynamic<String> = Dynamic<String>("")
    var image: Dynamic<UIImage> = Dynamic<UIImage>(UIImage())

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Propeties
    /* ////////////////////////////////////////////////////////////////////// */

    var nameString: String{

        return self.model.name
    }

    var categoryString: String{

        return self.model.category
    }

    var priceString: String{

        return String(self.model.price)
    }

    var imageURL: String{

        return "https://rdb-simpledb.restdb.io/media/\(self.model.image)?s=t"
    }

}
