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
    var sortModel: Sort = .name

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Binding Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var reloadTabelView: Dynamic<Bool> = Dynamic<Bool>(false)
    /// 0: Success, 1: Failure
    var cantConnectToServer: Dynamic<(Selector, Selector?)?> = Dynamic<(Selector, Selector?)?>(nil)
    var isShowLoader: Dynamic<Bool> = Dynamic<Bool>(false)

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Function
    /* ////////////////////////////////////////////////////////////////////// */

    /// Start NMapSpace
    func startHomeSpace(host: HomeViewController){

        guard space == nil else { return }
        let router = HomeRouter(delegate: homeUIDelegate!, dataSource: nil)
        space = Shopping.startSpace(delegate: router)
    }

    @objc func loadDataFromServer(){

//        self.repository.getList { result in
//            self.handleRequestResult(result: result)
//        }

        self.repository.getGoods() { result in

            self.handleRequestResult(result: result)
        }

//        self.repository.getSports { result in
//
//            self.handleRequestResult(result: result)
//        }
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
        self.updateFilterdAndSortedData()
    }

    func sortDataBy(sort: Sort, value: Bool){

        self.sortModel = sort
        self.updateFilterdAndSortedData()
    }


    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Function
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func handleRequestResult(result:  Result<[ListModel], NetworkError>){

        switch result{

            case .failure(_):

                // Show Error
                self.cantConnectToServer.value = (#selector(self.loadDataFromServer),nil)
            case .success(let list):

                // Fill Data Model
                self.dataModel = list
                // Update List
                self.updateFilterdAndSortedData()
        }
    }

    fileprivate func updateFilterdAndSortedData() {

        // Filter Data Model By Categories
        var model = self.filterDataBy(categories: self.filterCategoriesModel, model: self.dataModel)
        // Sort Data Model By Sort Type
        model = self.sortDataBy(sort: self.sortModel, model: model)
        // Update Presentable Model
        self.presentableDataModel = model
        self.updateListBy(model: self.presentableDataModel)
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

    fileprivate func sortDataBy(sort: Sort, model: [ListModel]) -> [ListModel]{

        var list: [ListModel] = []
        if sort == .name{

            list = model.sorted(by: { $0.name < $1.name })
        }else if sort == .price{

            list = model.sorted(by: { $0.price < $1.price })
        }
        return list
    }

    fileprivate func sortDataByPrice(){

    }
}
