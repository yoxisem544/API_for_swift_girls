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
                            callback: @escaping (JSON?, Error?) -> ())
}

public struct NetworkClient : NetworkClientType {
    
    func fetchUser(callback: @escaping (String?, Error?) -> ()) {
        let url = "http://httpbin.org/post"
        let params = ["name": "Swift Girls"]
        
        makeRequest(url: url, method: HTTPMethod.post, parameters: params, callback: { (json, error) in
            if let json = json, error == nil {
                callback(json["json"]["name"].string, nil)
            } else {
                // error
                callback(nil, error)
            }
        })
    }

    func makeRequest(url: String,
                            method: HTTPMethod,
                            parameters: [String : Any],
                            callback: @escaping (JSON?, Error?) -> ()) {
        request(url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil)
        .validate()
        .response(completionHandler: { response in
            if let data = response.data, response.error == nil {
                let json = JSON(data: data)
                callback(json, nil)
            } else {
                // error
                callback(nil, response.error)
            }
        })
    }
    
}
