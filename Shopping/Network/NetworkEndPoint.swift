//
//  NetworkEndPoint.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation
import Alamofire

protocol NetworkEndPoint {

    var url:        String             { get }
    var server:     ServerEndPint      { get }
    var Method:     HTTPMethod         { get set }
    var Headers:    HTTPHeaders        { get set }
    var Parameters: Parameters         { get set }
    var Encoding:   ParameterEncoding  { get set }
}

extension NetworkEndPoint{

    func buildURLRequest(with url: URL) -> URLRequest {

        let request = URLRequest(url: url)
        return request
    }

    func hasAccessToken() -> Bool{

        return !self.accessToken.isEmpty
    }

    var accessToken: String{

        return "Config.shared.token.accessToken"
    }

    var accessTokenWithPerfix: String{

        return "Bearer \(self.accessToken)"
    }

    var authString: String{

        return "Authorization"
    }

    var uuid: String{

        return "Config.shared.uuid"
    }


}
