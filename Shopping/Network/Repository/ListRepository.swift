//
//  ListRepository.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol ListRepository {

    func getBooks(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void)
}

struct ListRepositoryImpl: ListRepository {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate let service: CoreNetworkService
    fileprivate let tools: NetworkTools

    init(service : CoreNetworkService = AlamofireNetworkImpl(),
         tools: NetworkTools = NetworkTools()) {

        self.service = service
        self.tools = tools
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Methods
    /* ////////////////////////////////////////////////////////////////////// */

    func getBooks(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void) {

        let endPoint = BooksApi.init()

        service.request(endPoint: endPoint) { result in

            switch result{

                case .failure(let err):

                    complation(.failure(err))
                case .success(let data):

                    guard let json = self.tools.makeJSON(data: data) else {

                        complation(.failure(.decodingFailed))
                        return
                    }
                let model = ListModel.parsArray(json: json)
                complation(.success(model))
            }
        }
    }
}
