//
//  DetailViewController.swift
//  ZYRouterManager
//
//  Created by luzhiyong on 2018/9/12.
//  Copyright © 2018年 ilealfy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var productId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.title = "我是详情页 我的id是\(productId)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
