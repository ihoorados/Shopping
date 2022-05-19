//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import UIKit


class HomeViewModelImpl{

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    let repository: ListRepository = ListRepositoryImpl()

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var space: Shopping?
    weak var homeUIDelegate: HomeUserInterface?

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Properties
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate var viewModelList: [ListTableViewModel] = []{

        didSet{

            self.tableViewDataSource.items = self.viewModelList
        }
    }

    fileprivate var tableViewDataSource: TableViewDataSource<ListTableViewCell, ListTableViewModel>!

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Binding Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var reloadTabelView: Dynamic<Bool> = Dynamic<Bool>(false)

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Function
    /* ////////////////////////////////////////////////////////////////////// */

    /// Start NMapSpace
    func startHomeSpace(host: HomeViewController){

        guard space == nil else { return }
        let router = HomeRouter(delegate: homeUIDelegate!, dataSource: nil)
        space = Shopping.startSpace(delegate: router)
    }

    func searchBarTextUpdatedWith(text: String){

        if text.isEmpty {

            self.viewModelList.removeAll()
            self.reloadTabelView.value = true
        }else{

            self.repository.getBooks { result in

                switch result{

                    case .failure(let err):

                        print("Faild")
                    case .success(let list):

                    var modelList: [ListTableViewModel] = []
                    for item in list{
                        modelList.append(ListTableViewModel(model: item))
                    }
                    self.viewModelList = modelList
                    self.reloadTabelView.value = true
                }
            }
        }
    }

    // Table View Data Source
    func getTabelViewDataSource(identifier: String) -> UITableViewDataSource{

        self.tableViewDataSource = TableViewDataSource<ListTableViewCell, ListTableViewModel>(items: self.viewModelList, identifire: identifier, configureCell: { (cell, viewModel, indexPath) in

            cell.viewModel = viewModel
        })

        return self.tableViewDataSource
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Function
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func getMocklist(){

        let model1 = ListModel(name: "Name 1", category: "Books", price: "234", image: "")
        let model2 = ListModel(name: "Name 2", category: "Books", price: "334", image: "")
        let model3 = ListModel(name: "Name 3", category: "Books", price: "144", image: "")
        let model4 = ListModel(name: "Name 4", category: "Books", price: "37", image: "")
        let model5 = ListModel(name: "Name 5", category: "Books", price: "44", image: "")

        self.viewModelList = [ListTableViewModel(model: model1),
                              ListTableViewModel(model: model2),
                              ListTableViewModel(model: model3),
                              ListTableViewModel(model: model4),
                              ListTableViewModel(model: model5)]
    }
}
