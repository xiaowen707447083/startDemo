//
//  ViewController.swift
//  MyFrame
//
//  Created by shenba on 16/3/31.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let req = ModelRequest(requestBody: "请求体", userApi: "api110")
        req.describe()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

