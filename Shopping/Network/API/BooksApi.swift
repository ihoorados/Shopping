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

    init(server: ServerEndPint = .asia) {

        let url = "https://shopping-ac8c.restdb.io/rest/books"
        self.url = url
        self.server = server
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
