//
//  User.swift
//  SwiftGirlsAPI
//
//  Created by David on 2017/3/20.
//  Copyright © 2017年 david. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct User {
    let name: String
}

extension User : JSONDecodable {
    
    init?(json: JSON) {
        guard let name = json["json"]["name"].string else { return nil }
        self.name = name
    }
    
}
