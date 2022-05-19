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

    func getList(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void)
    func getBooks(text: String, complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void)
    func getSports(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void)
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

    func getBooks(text: String, complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void) {

        let endPoint = BooksApi.init(text: text)

        service.request(endPoint: endPoint) { result in

            switch result{

                case .failure(let err):

                    complation(.failure(err))
                case .success(let data):

                    guard let json = self.tools.makeJSON(data: data) else {

                        complation(.failure(.decodingFailed))
                        return
                    }
                let model = ListModel.parsArray(json: json, category: "books")
                complation(.success(model))
            }
        }
    }

    func getSports(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void) {

        let endPoint = SportsApi.init()

        service.request(endPoint: endPoint) { result in

            switch result{

                case .failure(let err):

                    complation(.failure(err))
                case .success(let data):

                    guard let json = self.tools.makeJSON(data: data) else {

                        complation(.failure(.decodingFailed))
                        return
                    }
                let model = ListModel.parsArray(json: json, category: "sports")
                complation(.success(model))
            }
        }
    }

    func getList(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void) {

        complation(.success(getMocklist()))
    }

    fileprivate func getMocklist() -> [ListModel]{

        let model1 = ListModel(name: "Name 1", category: "books", price: "234.00", image: "")
        let model2 = ListModel(name: "Name 2", category: "books", price: "334.00", image: "")
        let model3 = ListModel(name: "Name 3", category: "books", price: "144.00", image: "")
        let model4 = ListModel(name: "Name 4", category: "books", price: "37.00", image: "")
        let model5 = ListModel(name: "Name 5", category: "books", price: "44.00", image: "")

        let model6 = ListModel(name: "Name 5", category: "sports", price: "34.00", image: "")
        let model7 = ListModel(name: "Name 5", category: "sports", price: "4234.00", image: "")
        let model8 = ListModel(name: "Name 5", category: "sports", price: "434.00", image: "")
        let model9 = ListModel(name: "Name 5", category: "sports", price: "434.5", image: "")
        let model10 = ListModel(name: "Name 5", category: "sports", price: "44.00", image: "")

        return [model1,model2,model3,model4,model5,model6,model7,model8,model9,model10]
    }
}
