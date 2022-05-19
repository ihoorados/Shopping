//
//  HomeViewController.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import UIKit

protocol HomeUserInterface: AnyObject {

    func start()
}

class HomeViewController: UIViewController {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    let viewModel: HomeViewModelImpl

    init(viewModel: HomeViewModelImpl) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.viewModel.homeUIDelegate = self
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Lifecycle
    /* ////////////////////////////////////////////////////////////////////// */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.startHomeSpace(host: self)
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: User InterFace Properties
    /* ////////////////////////////////////////////////////////////////////// */

    lazy var searchBar: UISearchBar = {

        let searchBar = UISearchBar()
        return searchBar
    }()

    let cellIdentifire = "ListTableViewCell"
    lazy var resultTableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.sizeToFit()
        tableView.rowHeight = 98.0
        return tableView
    }()

    lazy var filterButton: UIButton = {

        let button = UIButton(type: .custom)
        button.setTitle("Filter", for: .normal)
        button.setImage(UIImage.init(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 12.0)
        return button
    }()

    lazy var sortButton: UIButton = {

        let button = UIButton(type: .custom)
        button.setTitle("Sort", for: .normal)
        button.setImage(UIImage.init(systemName: "arrow.up.arrow.down"), for: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 12.0)
        return button
    }()

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Binding View Model
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func BindingViewModel(){

        self.viewModel.reloadTabelView.bind { reload in

            if reload{

                self.resultTableView.reloadData()
            }
        }
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Functions
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func setupUIView(){

        self.view.addSubview(searchBar)
        self.view.addSubview(sortButton)
        self.view.addSubview(filterButton)
        self.view.addSubview(resultTableView)
        self.searchBar.placeholder = "Search"

        self.resultTableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableViewCell.self))
        self.resultTableView.dataSource = self.viewModel.getTabelViewDataSource(identifier: cellIdentifire)
    }

    fileprivate func setupUILayout(){

        self.searchBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                    left: self.view.leftAnchor,
                                    right: self.view.rightAnchor,
                                    paddingLeft: 12.0,
                                    paddingRight: 12.0)

        self.sortButton.anchor(top: self.searchBar.bottomAnchor,
                               left: self.view.leftAnchor,
                               paddingTop: 12.0,
                               paddingLeft: 12.0,
                               width: 100.0,
                               height: 38.0,
                               cornerRadius: 8.0)

        self.filterButton.anchor(top: self.searchBar.bottomAnchor,
                                 left: self.sortButton.rightAnchor,
                                 paddingTop: 12.0,
                                 paddingLeft: 12.0,
                                 width: 100.0,
                                 height: 38.0,
                                 cornerRadius: 8.0)

        self.resultTableView.anchor(top: self.filterButton.bottomAnchor,
                                    left: self.view.leftAnchor,
                                    bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                    right: self.view.rightAnchor,
                                    paddingTop: 12.0,
                                    paddingLeft: 12.0,
                                    paddingBottom: 0.0,
                                    paddingRight: 12.0)
    }

    fileprivate func setupDependency(){

        self.searchBar.delegate = self
    }

    fileprivate func setupUIEvent(){

        self.filterButton.addTarget(self, action: #selector(self.filterButtonAction), for: .touchUpInside)
        self.sortButton.addTarget(self, action: #selector(self.sortButtonAction), for: .touchUpInside)

    }

    @objc func filterButtonAction(){

        let view = FilterView(frame: self.view.frame)
        self.addViewToViewController(view: view, navigation: .top)
    }

    @objc func sortButtonAction(){

        let view = SortView(frame: self.view.frame)
        self.addViewToViewController(view: view, navigation: .top)
    }

}

/* ////////////////////////////////////////////////////////////////////// */
// MARK: Home User Interface
/* ////////////////////////////////////////////////////////////////////// */

extension HomeViewController: HomeUserInterface{

    func start() {

        print("✅ Start Home UI")

        self.title = "STDev"
        self.view.backgroundColor = .systemBackground
        self.setupUIView()
        self.setupUILayout()
        self.setupUIEvent()
        self.setupDependency()
        self.BindingViewModel()

        self.viewModel.loadDataFromServer()
    }
}

/* ////////////////////////////////////////////////////////////////////// */
// MARK: Home User Interface
/* ////////////////////////////////////////////////////////////////////// */

extension HomeViewController: UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.viewModel.searchBarTextUpdatedWith(text: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
        self.viewModel.loadDataFromServer()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: false)
    }
}
