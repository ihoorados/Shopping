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

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Private Functions
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate func setupUIView(){

        self.view.addSubview(searchBar)
        self.searchBar.placeholder = "Search"
    }

    fileprivate func setupUILayout(){

        self.searchBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                    left: self.view.leftAnchor,
                                    right: self.view.rightAnchor,
                                    paddingLeft: 12.0,
                                    paddingRight: 12.0)
    }

    fileprivate func setupDependency(){

        self.searchBar.delegate = self
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
        self.setupDependency()
    }
}


extension HomeViewController: UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
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
