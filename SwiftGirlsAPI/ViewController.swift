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
        
        let networkClient = NetworkClient()
        
        networkClient.fetchUser { (name, error) in
            if let name = name, error == nil {
                self.displayingLabel.text = "Username: " + name
            } else {
                // error
                self.displayingLabel.text = "Request failed"
            }
        }
    }

}

