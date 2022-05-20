//
//  ListModel.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import SwiftyJSON

struct ListModel {

    let name: String
    let category: String
    let price: String
    let image: String

    /// Convert Json into List Model
    static func parser(json:JSON, category: String) -> ListModel{

        let data: JSON = json[category]

        let image: String = data["image"].string ?? ""
        let price: Double = data["price"].double ?? 0.0
        let name: String = data["name"].string ?? ""
        let doubleStr = String(format: "%.2f", price)
        return ListModel(name: name, category: category, price: doubleStr, image: image)
    }

    /// Parse Json into [List Model]
    static func parsArray(json: JSON, category: String) -> [ListModel]{

        var array: [ListModel] = []
        guard let items = json.array else {

            return array
        }
        for item in items{

            array.append(ListModel.parser(json: item, category: category))
        }
        return array
    }
}
