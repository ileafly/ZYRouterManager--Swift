//
//  ViewController.swift
//  ZYRouterManager
//
//  Created by luzhiyong on 2018/9/12.
//  Copyright © 2018年 ilealfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func jumpToDetail(_ sender: Any) {
        ZYRouterManager.routerWithSchema("router://detail?productId=2")
    }
    
    @IBAction func jumpToSearch(_ sender: Any) {
        ZYRouterManager.routerWithSchema("router://search")
    }
}

