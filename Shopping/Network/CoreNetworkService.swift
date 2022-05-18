//
//  CoreNetworkService.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

/// The Core Service can make a request and also cancel the request and session.
/// The Result we ecpect is Data or Error.
/// The Core Service should independ from the Fromework and use Swift Language feature so we can
/// have multiple implementation from core service such as Alamofire and URLSession.
///
///
/// - Parameters:
///     - endPoint: The *endPoint* Endpoint of the network.

protocol CoreNetworkService {

    typealias response = ((Swift.Result<Data,NetworkError>) -> Void)

    func request(endPoint: NetworkEndPoint,
                 completion: @escaping response)
    func cancelRequest()
}
