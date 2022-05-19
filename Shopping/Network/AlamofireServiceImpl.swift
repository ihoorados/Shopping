//
//  AlamofireServiceImpl.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//


import Foundation
import Alamofire

class AlamofireNetworkImpl: CoreNetworkService {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    fileprivate let Configuration: URLSessionConfiguration
    fileprivate var SessionManager: Alamofire.SessionManager

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {

        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["os"] = "iOS"
        defaultHeaders["x-apikey"] = "9513a3c681bc11841e3ab249c8b59e438d693"
        defaultHeaders["cache-control"] = "no-cache"

        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.urlCache = nil
        self.Configuration = configuration
        self.SessionManager = Alamofire.SessionManager(configuration: configuration)
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Methods
    /* ////////////////////////////////////////////////////////////////////// */

    func request(endPoint: NetworkEndPoint,
                 completion: @escaping response) {

        SessionManager.request(endPoint.url,
                               method: endPoint.Method,
                               parameters: endPoint.Parameters,
                               encoding: endPoint.Encoding,
                               headers: endPoint.Headers)

            .validate(statusCode: 200..<300)
            .responseData { response in

                switch response.result {
                case .success:

                    guard let data = response.data else {

                        completion(.failure(.noData))
                        return
                    }
                    completion(.success(data))

                case .failure(let error):

                    print("🔴 AlamofireNetworkImpl: request to \(endPoint) failed with error : \(error)")
                    completion(.failure(.failed))
                }
        }
    }

    func cancelRequest(){

        SessionManager.session.invalidateAndCancel()
        SessionManager = sessionManager(configuration: self.Configuration)
    }

    fileprivate func sessionManager(configuration: URLSessionConfiguration) -> SessionManager{

        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }

}
