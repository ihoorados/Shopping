//
//  BooksApi.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//


import Foundation
import Alamofire

struct BooksApi: NetworkEndPoint {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    init(server: ServerEndPint = .asia, text: String?) {

        var url: String
        self.server = server
        url = "https://categories-6305.restdb.io/rest/list"

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
