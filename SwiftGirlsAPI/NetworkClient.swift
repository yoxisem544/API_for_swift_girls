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
import PromiseKit

protocol NetworkClientType {
    func makeRequest<Request: NetworkRequest>(networkRequest: Request) -> Promise<Data>
}

public struct NetworkClient : NetworkClientType {
    
    func makeRequest<Request : NetworkRequest>(networkRequest: Request) -> Promise<Data> {
        
        let (promise, fulfill, reject) = Promise<Data>.pending()
        
        request(networkRequest.url,
                method: networkRequest.method,
                parameters: networkRequest.parameters,
                encoding: networkRequest.encoding,
                headers: networkRequest.headers)
        .validate()
        .response(completionHandler: { response in
            if let data = response.data, response.error == nil {
                fulfill(data)
            } else {
                // error
                reject(response.error!)
            }
        })
        
        return promise
    }
    
}
