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

public struct NetworkClient {

    static func makeRequest(url: String,
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
