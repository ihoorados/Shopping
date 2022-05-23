//
//  Goods.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 23/5/2022.
//

import Foundation
import Alamofire

struct GoodsApi: NetworkEndPoint {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    init(server: ServerEndPint = .asia) {

        self.server = server
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var url: String = "https://shopping-ac8c.restdb.io/rest/goods"
    var server: ServerEndPint = .asia
    var Method: HTTPMethod = .get
    var Encoding: ParameterEncoding = URLEncoding.default
    var Parameters: Parameters = [:]
    var Headers: HTTPHeaders = [:]
}
