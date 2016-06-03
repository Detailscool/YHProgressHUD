//
//  UINavigationBar+YHProgressHUD.swift
//  YHProgressHUD
//
//  Created by Detailscool on 16/6/3.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

var YHProgressHUD_NavBarKey = "YHProgressHUD_NavBar"

extension UINavigationBar {
    
    var yhProgressHUD_NavBar :YHProgressHUD_NavBar {
        get{
            if let progressHUD_NavBar = objc_getAssociatedObject(self, &YHProgressHUD_NavBarKey) as? YHProgressHUD_NavBar {
                return progressHUD_NavBar
            }else {
                let progressHUD_NavBar = YHProgressHUD_NavBar()
                self.yhProgressHUD_NavBar = progressHUD_NavBar
                return progressHUD_NavBar
            }
        }
        
        set {
            insertSubview(newValue, atIndex: 0)
            objc_setAssociatedObject(self, &YHProgressHUD_NavBarKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
}

extension UINavigationController {
    
    func showWithStatus(status:String) {
        navigationBar.yhProgressHUD_NavBar.setStatusText(status)
        navigationBar.yhProgressHUD_NavBar.hidden = false;
        UIView.animateWithDuration(YHProgressAnimationDuration, animations: {
            self.navigationBar.yhProgressHUD_NavBar.frame = CGRect(x: 0, y: CGRectGetHeight(self.navigationBar.frame), width: YHProgressHUDScreenWidth, height: YHProgressHUDNavigationBarHeight)
        }) { (_) in
            
        }
    }
    
    func showSuccessWithStatus(status:String,duration:NSTimeInterval = YHProgressDefaultStayDuration) {
        showWithStatus(status)
        performSelector(#selector(UINavigationController.dismiss), withObject: nil, afterDelay: duration)
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.25, animations: { 
            self.navigationBar.yhProgressHUD_NavBar.frame = CGRect(x: 0, y: -YHProgressHUDNavigationBarHeight, width: YHProgressHUDScreenWidth, height: YHProgressHUDNavigationBarHeight)
            }) { (_) in
             self.navigationBar.yhProgressHUD_NavBar.hidden = true;
        }
    }
    
}