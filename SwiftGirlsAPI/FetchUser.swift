//
//  FetchUser.swift
//  SwiftGirlsAPI
//
//  Created by David on 2017/3/20.
//  Copyright © 2017年 david. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

final public class FetchUser : NetworkRequest {
    typealias ResponseType = User
    
    var endpoint: String { return "/post" }
    public var method: HTTPMethod { return .post }
    public var parameters: [String : Any]? { return ["name": name] }
    
    private var name: String = ""
    public func perform(name: String) -> Promise<User> {
        self.name = name
        return networkClient.makeRequest(networkRequest: self).then(execute: responseHandler)
    }
    
}
