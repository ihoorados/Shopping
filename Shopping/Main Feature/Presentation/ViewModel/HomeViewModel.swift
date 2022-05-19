//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import UIKit


class HomeViewModelImpl{


    init(){


    }

    var space: Shopping?
    weak var homeUIDelegate: HomeUserInterface?

    fileprivate var viewModelList: [ListTableViewModel] = []{

        didSet{

            self.tableViewDataSource.items = self.viewModelList
        }
    }

    fileprivate var tableViewDataSource: TableViewDataSource<ListTableViewCell, ListTableViewModel>!

    var reloadTabelView: Dynamic<Bool> = Dynamic<Bool>(false)


    /// Start NMapSpace
    func startHomeSpace(host: HomeViewController){

        guard space == nil else { return }
        let router = HomeRouter(delegate: homeUIDelegate!, dataSource: nil)
        space = Shopping.startSpace(delegate: router)
    }



    func searchBarTextUpdatedWith(text: String){

        if text.isEmpty {

            self.viewModelList.removeAll()
        }else{

            self.getMocklist()
        }
        self.reloadTabelView.value = true
    }

    
    func getMocklist(){

        self.viewModelList = [ListTableViewModel(model: "Product 1 Product 1 Product 1 Product 1 Product 1 Product 1"),
                              ListTableViewModel(model: "Product 2"),
                              ListTableViewModel(model: "Product 3"),
                              ListTableViewModel(model: "Product 4")]
    }

    // Table View Data Source
    func getTabelViewDataSource(identifier: String) -> UITableViewDataSource{

        self.tableViewDataSource = TableViewDataSource<ListTableViewCell, ListTableViewModel>(items: self.viewModelList, identifire: identifier, configureCell: { (cell, viewModel, indexPath) in

            cell.viewModel = viewModel
        })

        return self.tableViewDataSource
    }
}
