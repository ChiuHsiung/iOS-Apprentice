//
//  ViewController.swift
//  BullsEye_SW
//
//  Created by zhuangqiuxiong on 16/3/13.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
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

    @IBAction func showAlert(sender: AnyObject) {
        
        let alert = UIAlertView(title: "Hello, world", message: "This is my first app!", delegate: nil, cancelButtonTitle: "Awesome")
        
        alert.show()
    
    }

}

