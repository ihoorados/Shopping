//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import UIKit


protocol HomeViewModel {

    var reloadTabelView: Dynamic<Bool> { get set }
    var cantConnectToServer: Dynamic<(Selector, Selector?)?> { get set }
    var isShowLoader: Dynamic<Bool> { get set }
    var homeUIDelegate: HomeUserInterface? { get set }
    var filterCategoriesModel: [Categories] { get set }
    var sortModel: Sort { get set }

    func startHomeSpace(host: HomeViewController)
    func searchBarTextUpdatedWith(text: String)
    func loadDataFromServer()
    func getTabelViewDataSource(identifier: String) -> UITableViewDataSource
    func filterDataBy(category: Categories, value: Bool)
    func sortDataBy(sort: Sort, value: Bool)
}


class HomeViewModelImpl: HomeViewModel{

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
    fileprivate var searchString: String = ""

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

        self.isShowLoader.value = true
        self.repository.getGoods() { result in

            self.isShowLoader.value = false
            self.handleRequestResult(result: result)
        }
    }

    func searchBarTextUpdatedWith(text: String){

        self.searchString = text
        guard !text.isEmpty else {

            self.viewModelList.removeAll()
            self.updateFilterdAndSortedData()
            return
        }

        let model = ListModel.filterDataBy(text: text, model: self.presentableDataModel)
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
        var model = ListModel.filterDataBy(categories: self.filterCategoriesModel, model: self.dataModel)
        // Sort Data Model By Sort Type
        model = ListModel.sortDataBy(sort: self.sortModel, model: model)
        // Filter Data By String
        model = ListModel.filterDataBy(text: self.searchString, model: model)
        // Update Presentable Model
        self.presentableDataModel = model
        // Update TableView List
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
