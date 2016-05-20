//
//  YHProgressHUD.swift
//  YHProgressHUD
//
//  Created by 陈波文 on 16/5/20.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

class YHProgressHUD: NSObject {
    
    static let progress = YHProgressHUD()
    
    class func sharedProgress() -> YHProgressHUD {
        return progress
    }
    
    private override init() {
        super.init()
    }
    
    private class func show(finished:(Void -> Void)?) {
        showWindow.frame = CGRect(x: 0, y: -20, width: UIScreen.mainScreen().bounds.width,height: 20)
        UIView.animateWithDuration(0.25, animations: {
            showWindow.hidden = false
            showWindow.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 20)
        }) { (_) in
            if let _ = finished {
                finished!()
            }
        }
        
    }
    
    class func dismiss() {
        UIView.animateWithDuration(0.25, animations: {
            showWindow.frame = CGRect(x: 0, y: -20, width: UIScreen.mainScreen().bounds.width, height: 20)
        }) { (_) in
            showWindow.hidden = true
        }
    }
    
    class func showWithStatus(status:String) {
        showWindow.setStatusText(status)
        show(nil)
    }
    
    class func showSucessWithStatus(status:String) {
        showWindow.setStatusText(status)
        show { () in
            performSelector(#selector(YHProgressHUD.dismiss), withObject: nil, afterDelay: 1.5)
        }
    }
    
    static let showWindow : ShowingWindow = {
        let w = ShowingWindow()
        w.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        return w
    }()
    
    class ShowingWindow: UIWindow {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setStatusText(status:String) {
            statusLabel.text = status
        }
        
        func setIconViewImage(icon:UIImage) {
            iconView.image = icon
        }
        
        private func setup() {
            rootViewController = UIViewController()
            windowLevel = UIWindowLevelStatusBar
            hidden = true;
            
            addSubview(statusLabel)
            addSubview(iconView)
            
            statusLabel.translatesAutoresizingMaskIntoConstraints = false
            iconView.translatesAutoresizingMaskIntoConstraints = false
            
            addConstraint(NSLayoutConstraint.init(item: statusLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint.init(item: statusLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint.init(item: iconView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: statusLabel, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: -10))
            addConstraint(NSLayoutConstraint.init(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
            
        }
        
        private lazy var statusLabel : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.whiteColor()
            label.textAlignment = NSTextAlignment.Center
            label.sizeToFit()
            return label
        }()
        
        private lazy var iconView : UIImageView = {
            let iv = UIImageView()
            iv.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
            return iv
        }()
        
    }
}
