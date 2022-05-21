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

    fileprivate var dataModel: [ListModel] = []
    fileprivate var presentableDataModel: [ListModel] = []
    fileprivate var tableViewDataSource: TableViewDataSource<ListTableViewCell, ListTableViewModel>!

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var filterCategoriesModel: [Categories] = []
    var sortModel: [Sort] = []

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

//        let model = self.filterDataBy(categories: [.books,.sport])
//        self.updateListBy(model: model)
    }

    func searchBarTextUpdatedWith(text: String){

        guard !text.isEmpty else {

            self.viewModelList.removeAll()
            self.loadDataFromServer()
            return
        }

        let model = self.filterDataBy(string: text)
        self.updateListBy(model: model)
    }

    // Table View Data Source
    func getTabelViewDataSource(identifier: String) -> UITableViewDataSource{

        self.tableViewDataSource = TableViewDataSource<ListTableViewCell, ListTableViewModel>(items: self.viewModelList, identifire: identifier, configureCell: { (cell, viewModel, indexPath) in

            cell.viewModel = viewModel
        })

        return self.tableViewDataSource
    }

    func filterDataBy(category: Categories, value: Bool){

        if value && !filterCategoriesModel.contains(category){

            self.filterCategoriesModel.append(category)
        }else{

            if let index = self.filterCategoriesModel.firstIndex(of: category) {
                self.filterCategoriesModel.remove(at: index)
            }
        }

        guard !self.filterCategoriesModel.isEmpty else {

            self.loadDataFromServer()
            return
        }

        let model = self.filterDataBy(categories: self.filterCategoriesModel, model: self.dataModel)
        self.presentableDataModel = model
        self.updateListBy(model: self.presentableDataModel)
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
                var model = self.filterDataBy(categories: self.filterCategoriesModel, model: self.dataModel)
                self.presentableDataModel = model
                model = self.sortDataBy(sort: self.sortModel)
                self.updateListBy(model: model)
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
}

/* ////////////////////////////////////////////////////////////////////// */
// MARK: Filter & Sort
/* ////////////////////////////////////////////////////////////////////// */

extension HomeViewModelImpl{

    fileprivate func filterDataBy(string: String) -> [ListModel]{

        return presentableDataModel.filter { $0.name.contains(string) }
    }

    fileprivate func filterDataBy(categories: [Categories], model: [ListModel]) -> [ListModel]{

        guard !categories.isEmpty else {

            return model
        }

        var list: [ListModel] = []
        categories.forEach { category in

            list.append(contentsOf: model.filter { $0.category.contains(category.rawValue) })
        }
        return list
    }

    fileprivate func sortDataBy(sort: [Sort]) -> [ListModel]{

        return self.presentableDataModel
    }

    fileprivate func sortDataByPrice(){

    }
}
