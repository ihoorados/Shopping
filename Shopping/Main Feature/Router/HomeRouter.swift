//
//  HomeRouter.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

final class HomeRouter: HomeUseCase{

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    weak var UIDelegate: HomeUserInterface?

    init(delegate: HomeUserInterface, dataSource: AnyObject?) {

        self.UIDelegate = delegate
        print("🟦 NMapNavigatorRouter: init.")
    }

    deinit{

        print("🗑 NMapNavigatorRouter: deinit.")
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Function
    /* ////////////////////////////////////////////////////////////////////// */

    func startHome(){

        print("🟩 NMapNavigatorRouter: start Navigator.")
        self.UIDelegate?.start()
    }

}


