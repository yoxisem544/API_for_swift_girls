//
//  NetworkRequest.swift
//  SwiftGirlsAPI
//
//  Created by David on 2017/3/20.
//  Copyright © 2017年 david. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

protocol NetworkRequest {
    associatedtype ResponseType
    
    // Required
    /// End Point.
    /// e.g. /cards/:id/dislike
    var endpoint: String { get }
    /// Will transform given data to requested type of response.
    var responseHandler: (Data) throws -> ResponseType { get }
    
    // Optional
    var baseURL: String { get }
    /// Method to make the request. E.g. get, post.
    var method: Alamofire.HTTPMethod { get }
    /// Parameter encoding. E.g. JSON, URLEncoding.default.
    var encoding: Alamofire.ParameterEncoding { get }
    
    var parameters: [String : Any]? { get }
    var headers: [String : String] { get }
    
    /// Client that helps you to make reqeust.
    var networkClient: NetworkClientType { get }
}

extension NetworkRequest {
    public var url: String { return baseURL + endpoint }
    public var baseURL: String { return "http://httpbin.org" }
    public var method: Alamofire.HTTPMethod { return .get }
    public var encoding: Alamofire.ParameterEncoding { return JSONEncoding.default }
    
    public var parameters: [String : Any]? { return nil }
    public var headers: [String : String] { return [:] }
    
    public var networkClient: NetworkClientType { return NetworkClient() }
}

extension NetworkRequest where ResponseType : JSONDecodable {
    var responseHandler: (Data) throws -> ResponseType { return jsonResponseHandler }
}

private func jsonResponseHandler<Response : JSONDecodable>(data: Data) throws -> Response {
    let json = JSON(data: data)
    return try Response(json: json)
}
