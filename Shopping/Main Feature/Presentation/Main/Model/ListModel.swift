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
    let price: Double
    let image: String

    /// Convert Json into List Model
    static func parser(json:JSON, category: String) -> ListModel{

        //let data: JSON = json[category]

        let imageArr: Array = json["image"].array ?? []
        let image: String = imageArr.first?.stringValue ?? ""
        let price: Double = json["price"].double ?? 0.0
        let name: String = json["name"].string ?? ""
        let doubleStr = String(format: "%.2f", price)
        return ListModel(name: name, category: category, price: Double(doubleStr) ?? 0.0, image: image)
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


    /// Parse Json into [List Model]
    static func parsAllGoods(json: JSON) -> [ListModel]{

        //print(json)

        var array: [ListModel] = []

        guard let items = json.array else {

            return array
        }

        for item in items {

            if let data: Array = item["books"].array{

                for item in data{

                    array.append(ListModel.parser(json: item, category: "Books"))
                }
            }

            if let data: Array = item["music"].array{

                for item in data{

                    array.append(ListModel.parser(json: item, category: "Music"))
                }
            }

            if let data: Array = item["travel"].array{

                for item in data{

                    array.append(ListModel.parser(json: item, category: "Travel"))
                }
            }

            if let data: Array = item["sport"].array{

                for item in data{

                    array.append(ListModel.parser(json: item, category: "Sport"))
                }
            }

            if let data: Array = item["electronics"].array{

                for item in data{

                    array.append(ListModel.parser(json: item, category: "Electronics"))
                }
            }

            if let data: Array = item["other"].array{

                for item in data{

                    array.append(ListModel.parser(json: item, category: "Other"))
                }
            }
        }

        return array
    }
}
