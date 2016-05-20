//
//  ViewController.swift
//  YHProgressHUD
//
//  Created by 陈波文 on 16/5/20.
//  Copyright © 2016年 Detailscool. All rights reserved.
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

    @IBAction func aaaClick(sender: AnyObject) {
//        YHProgressHUD.show()
//        YHProgressHUD.showWithStatus("正在加载")
        YHProgressHUD.showSucessWithStatus("成功加载")
        print("111")
    }
    
    @IBAction func bbbClick(sender: AnyObject) {
        YHProgressHUD.dismiss()
        print("222")
    }
    

}

