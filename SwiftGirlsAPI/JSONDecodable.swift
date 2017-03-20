//
//  JSONDecodable.swift
//  SwiftGirlsAPI
//
//  Created by David on 2017/3/20.
//  Copyright © 2017年 david. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONDecodable {
    init(json: JSON) throws
}

enum JSONDecodableError: Error {
    case missingKey
}
