//
//  ViewController.swift
//  YHProgressHUDDemo
//
//  Created by Detailscool on 16/6/3.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showEffection(sender: UIButton) {
        
        switch sender.tag {
        case 1001:
           YHProgressHUD.showWithStatus("加载成功")
        case 1002:
            YHProgressHUD.dismiss()
        case 1003:
            YHProgressHUD.showSuccessWithStatus("加载成功")
        case 1004:
            navigationController?.showWithStatus("加载成功")
        case 1005:
            navigationController?.dismiss()
        case 1006:
            navigationController?.showSuccessWithStatus("加载成功")
        default:
            break
        }
    }


}

