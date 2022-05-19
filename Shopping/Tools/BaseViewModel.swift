//
//  BaseViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

class BaseViewModel: NSObject{

    /// 0: Success, 1: Failure
    var cantConnectToServer: Dynamic<(Selector, Selector?)?> = Dynamic<(Selector, Selector?)?>(nil)
    var isShowLoader: Dynamic<Bool> = Dynamic<Bool>(false)
}
