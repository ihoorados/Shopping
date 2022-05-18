//
//  NetworkTools.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import SwiftyJSON

struct NetworkTools {

    // Model To Parameter
    func modelToParameter<T: Codable>(model: T) -> [String: Any]?{

        do {

            var json: [String: Any]? = [:]
            let jsonEncoder: JSONEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(model)
            json = (try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any])
            return json
        } catch{

            return nil
        }
    }

    // MARK: Make JSON From Data
    func makeJSON(data: Data) -> JSON?{

        let json = try? JSON(data: data)
        return json
    }

    func makePostString(params:[String:Any]) -> String {

        var data = [String]()
        for(key, value) in params {

            data.append(key + "=\(value)")
        }

        return data.map { String($0) }.joined(separator: "&")
    }

}
