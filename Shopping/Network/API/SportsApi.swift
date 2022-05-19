//
//  SportsApi.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 20/5/2022.
//

import Foundation
import Alamofire

struct SportsApi: NetworkEndPoint {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    init(server: ServerEndPint = .asia) {

        self.server = server
        let url = "https://categories-6305.restdb.io/rest/sports"
        self.url = url
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Public Properties
    /* ////////////////////////////////////////////////////////////////////// */

    var url: String = ""
    var server: ServerEndPint = .asia
    var Method: HTTPMethod = .get
    var Encoding: ParameterEncoding = URLEncoding.default
    var Parameters: Parameters = [:]
    var Headers: HTTPHeaders = [:]
}
