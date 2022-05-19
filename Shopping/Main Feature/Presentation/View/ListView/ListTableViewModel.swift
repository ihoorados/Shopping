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

    var model: String

    init(model: String) {

        self.model = model

        super.init()
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Observable Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var image: Dynamic<UIImage> = Dynamic<UIImage>(UIImage())
    var isRead: Dynamic<Bool> = Dynamic<Bool>(false)

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Propeties
    /* ////////////////////////////////////////////////////////////////////// */

    // MARK: Public
    var title: String{

        return self.model
    }

    var nameString: String{

        return self.model
    }

    var categoryStiring: String{

        return self.model
    }

    var priceStiring: String{

        return self.model
    }

}
