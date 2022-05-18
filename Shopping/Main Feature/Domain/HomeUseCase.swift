//
//  HomeUseCase.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

import Foundation

protocol HomeUseCase: AnyObject{

    init(delegate: HomeUserInterface, dataSource: AnyObject?)
    func startHome()
}
