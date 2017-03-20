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
        
        let fetchUser = FetchUser()
        
        fetchUser.perform(name: "Swift Girls") { (user, error) in
            if let user = user, error == nil {
                self.displayingLabel.text = "Username: " + user.name
            } else {
                // error
                self.displayingLabel.text = "Request failed"
            }
        }
    }

}

