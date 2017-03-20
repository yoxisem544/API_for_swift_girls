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
    func makeRequest(url: String,
                            method: HTTPMethod,
                            parameters: [String : Any],
                            callback: @escaping (User?, Error?) -> ())
}

public struct NetworkClient : NetworkClientType {
    
    func fetchUser(callback: @escaping (User?, Error?) -> ()) {
        let url = "http://httpbin.org/post"
        let params = ["name": "Swift Girls"]
        
        makeRequest(url: url, method: HTTPMethod.post, parameters: params, callback: { (user, error) in
            if let user = user, error == nil {
                callback(user, nil)
            } else {
                // error
                callback(nil, error)
            }
        })
    }

    func makeRequest(url: String,
                            method: HTTPMethod,
                            parameters: [String : Any],
                            callback: @escaping (User?, Error?) -> ()) {
        request(url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil)
        .validate()
        .response(completionHandler: { response in
            if let data = response.data, response.error == nil {
                let json = JSON(data: data)
                let user = User(json: json)
                callback(user, nil)
            } else {
                // error
                callback(nil, response.error)
            }
        })
    }
    
}
