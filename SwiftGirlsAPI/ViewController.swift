//
//  ViewController.swift
//  SwiftGirlsAPI
//
//  Created by David on 2017/3/20.
//  Copyright © 2017年 david. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

final public class ViewController: UIViewController {

    @IBOutlet weak var displayingLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://httpbin.org/post"
        let params = ["name": "Swift Girls"]
        
        NetworkClient.makeRequest(url: url,
                                  method: HTTPMethod.post,
                                  parameters: params,
        callback: { (json, error) in
            if let json = json, error == nil {
                self.displayingLabel.text = "Username: " + json["json"]["name"].stringValue
            } else {
                // error
                self.displayingLabel.text = "Request failed"
            }
        })
    }

}

