//
//  NetworkClient.swift
//  SwiftGirlsAPI
//
//  Created by David on 2017/3/20.
//  Copyright © 2017年 david. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol NetworkClientType {
    func makeRequest<Request: NetworkRequest>(networkRequest: Request,
                                              callback: @escaping (Data?, Error?) -> ())
}

public struct NetworkClient : NetworkClientType {
    
    func makeRequest<Request : NetworkRequest>(networkRequest: Request,
                     callback: @escaping (Data?, Error?) -> ()) {
        request(networkRequest.url,
                method: networkRequest.method,
                parameters: networkRequest.parameters,
                encoding: networkRequest.encoding,
                headers: networkRequest.headers)
        .validate()
        .response(completionHandler: { response in
            if let data = response.data, response.error == nil {
                callback(data, nil)
            } else {
                // error
                callback(nil, response.error)
            }
        })
    }
    
}
