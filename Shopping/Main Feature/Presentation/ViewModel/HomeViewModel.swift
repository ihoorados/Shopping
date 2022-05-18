//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation


class HomeViewModelImpl{


    init(){}

    var space: Shopping?
    weak var homeUIDelegate: HomeUserInterface?


    /// Start NMapSpace
    func startHomeSpace(host: HomeViewController){

        guard space == nil else { return }
        let router = HomeRouter(delegate: homeUIDelegate!, dataSource: nil)
        space = Shopping.startSpace(delegate: router)
    }
}
