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

    static func parser(json:JSON) -> ListModel{

        let image: String = json["image"].string ?? ""
        let price: Double = json["price"].double ?? 0.0
        let name: String = json["name"].string ?? ""
        let doubleStr = String(format: "%.2f", price)
        return ListModel(name: name, category: "Books", price: doubleStr, image: image)
    }

    static func parsArray(json: JSON) -> [ListModel]{

        var array: [ListModel] = []
        guard let items = json.array else {

            return array
        }

        for item in items{

            array.append(ListModel.parser(json: item))
        }

        return array
    }
}
