//
//  ViewController.swift
//  useray
//
//  Created by Mobile Developer on 8/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var appModel:AppModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appModel?.importUsers(({
            println(self.appModel?.loadUsers())
        }))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

