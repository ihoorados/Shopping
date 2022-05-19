//
//  UITableViewDataSource.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//


import Foundation
import UIKit

class TableViewDataSource<CellType,Model>: NSObject, UITableViewDataSource where CellType: UITableViewCell, Model: BaseViewModel{

    // Variable
    var items: [Model]
    let configureCell: (CellType, Model, IndexPath) -> ()
    let identifire: String
    var dontShowNoItemMessage: Bool = false
    fileprivate var seperatorStyle: UITableViewCell.SeparatorStyle = .none

    // Mark: Init
    init(items: [Model], identifire: String, configureCell: @escaping (CellType, Model, IndexPath) -> ()) {

        self.items = items
        self.configureCell = configureCell
        self.identifire = identifire
    }

    // Update
    func updateItems(_ items: [Model]) {

        self.items = items
    }

    // Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.dontShowNoItemMessage || self.items.count != 0{

            tableView.removeNoItemToFound()
        }else{

            tableView.setNoItemToFound()
        }
        return self.items.count
    }

    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellFinder: CellType? = tableView.dequeueReusableCell(withIdentifier: self.identifire, for: indexPath) as? CellType

        guard let cell = cellFinder else {

            fatalError("Cell with identifier: \(self.identifire)")
        }

        let m = self.items[indexPath.row]
        self.configureCell(cell, m, indexPath)
        return cell
    }

}

extension UITableView{

    func setNoItemToFound(text: String = "No Result", isTransformHorizontally: Bool = false){

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textAlignment = .center
        label.sizeToFit()
        self.backgroundView = label
        if isTransformHorizontally{

            label.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }

    func removeNoItemToFound(){

        self.backgroundView = nil
    }
}

