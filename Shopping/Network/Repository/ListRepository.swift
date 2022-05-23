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

    func getGoods(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void)
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
                let model = ListModel.parsArray(json: json, category: "Books")
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

    func getGoods(complation: @escaping (Swift.Result<[ListModel], NetworkError>) -> Void) {

        let endPoint = GoodsApi.init()

        service.request(endPoint: endPoint) { result in

            switch result{

                case .failure(let err):

                    complation(.failure(err))
                case .success(let data):

                    guard let json = self.tools.makeJSON(data: data) else {

                        complation(.failure(.decodingFailed))
                        return
                    }
                let model = ListModel.parsAllGoods(json: json)
                complation(.success(model))
            }
        }
    }


    fileprivate func getMocklist() -> [ListModel]{

        let model1 = ListModel(name: "Francette", category: "Books", price: 234.00, image: "")
        let model2 = ListModel(name: "Dinesh", category: "Books", price: 334.00, image: "")
        let model3 = ListModel(name: "Willibald", category: "Books", price: 144.00, image: "")
        let model4 = ListModel(name: "Brochfael", category: "Books", price: 37.00, image: "")
        let model5 = ListModel(name: "Brice", category: "Books", price: 44.00, image: "")

        let model6 = ListModel(name: "Libitina", category: "Sports", price: 34.00, image: "")
        let model7 = ListModel(name: "Jesús", category: "Sports", price: 4234.00, image: "")
        let model8 = ListModel(name: "Tsubaki", category: "Sports", price: 434.00, image: "")
        let model9 = ListModel(name: "Amrit", category: "Sports", price: 434.5, image: "")
        let model10 = ListModel(name: "Nwanneka", category: "Sports", price: 44.00, image: "")
        let model16 = ListModel(name: "Secret of the Floridian Mermaid", category: "Sports", price: 44.00, image: "")
        let model17 = ListModel(name: "First Eyes", category: "Sports", price: 44.00, image: "")
        let model18 = ListModel(name: "The Frozen Sparks", category: "Sports", price: 44.00, image: "")
        let model19 = ListModel(name: "River of Servants", category: "Sports", price: 44.00, image: "")
        let model20 = ListModel(name: "The Tower's Girl", category: "Sports", price: 44.00, image: "")
        let model21 = ListModel(name: "The Tower of the Kiss", category: "Sports", price: 44.00, image: "")

        let model11 = ListModel(name: "Selma", category: "Travel", price: 34.00, image: "")
        let model12 = ListModel(name: "Mbali", category: "Travel", price: 4234.00, image: "")
        let model13 = ListModel(name: "Alwin", category: "Travel", price: 434.00, image: "")
        let model14 = ListModel(name: "Cibrán", category: "Travel", price: 434.5, image: "")
        let model15 = ListModel(name: "John", category: "Travel", price: 44.00, image: "")

        return [model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12,model13,model14,model15,model16,model17,model18,model19,model20,model21]
    }
}
