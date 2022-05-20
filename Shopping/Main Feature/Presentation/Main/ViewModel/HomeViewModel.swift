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

    fileprivate var viewModelSearchList: [ListTableViewModel] = []{

        didSet{

            self.tableViewDataSource.items = self.viewModelSearchList
        }
    }

    fileprivate var dataModel: [ListModel] = []

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

        guard !text.isEmpty else {

            self.viewModelList.removeAll()
            self.loadDataFromServer()
            return
        }

        let model = self.filterDataBy(categories: ["Books"])
        self.updateListBy(model: model)

//        let model = self.filterDataBy(string: text)
//        self.updateListBy(model: model)
    }

    func loadDataFromServer(){

        self.repository.getList { result in
            self.handleRequestResult(result: result)
        }

//        self.repository.getBooks(text: "text") { result in
//
//            self.handleRequestResult(result: result)
//        }

//        self.repository.getSports { result in
//
//            self.handleRequestResult(result: result)
//        }
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

    fileprivate func handleRequestResult(result:  Result<[ListModel], NetworkError>){

        switch result{

            case .failure(let _):

                print("Faild")
            case .success(let list):

                self.dataModel = list
                self.updateListBy(model: list)
        }
    }

    fileprivate func updateListBy(model: [ListModel]){

        self.viewModelList.removeAll()
        var modelList: [ListTableViewModel] = []
        for item in model{
            modelList.append(ListTableViewModel(model: item))
        }
        self.viewModelList.append(contentsOf: modelList)
        self.reloadTabelView.value = true
    }



    fileprivate func filterDataBy(string: String) -> [ListModel]{

        return dataModel.filter { $0.name.contains(string) }
    }

    fileprivate func filterDataBy(categories: [String]) -> [ListModel]{

        let model = dataModel.filter { $0.category.contains("Books") }
        return model
    }
}
