//
//  URLSessionServiceImpl.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

class URLSessionNetworkImpl: CoreNetworkService {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    private var session : URLSession
    private var tools: NetworkTools = NetworkTools()

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Methods
    /* ////////////////////////////////////////////////////////////////////// */

    private var task: URLSessionTask?

    //MARK: Start Task
    func request(endPoint: NetworkEndPoint, completion: @escaping response) {


        guard let url = URL(string: endPoint.url) else {

            completion(.failure(.missingURL))
            return
        }
        var request = endPoint.buildURLRequest(with: url)
        request.httpMethod = endPoint.Method.rawValue
        request.allHTTPHeaderFields = endPoint.Headers

        task = session.dataTask(with: request,
                                completionHandler: { (data, response, error) in

            // MARK: 1. Check error
            if let _ = error {

                completion(.failure(.failed))
            }

            // MARK: 3. Validate data
            guard let data = data else{

                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        })

        // MARK: Start Task
        print("🟣 URLSessionNetworkImpl: Start request to \(endPoint).")
        task?.resume()
    }

    func cancelRequest() {
        // MARK: Cancel Data Task
        task?.cancel()
    }

}
