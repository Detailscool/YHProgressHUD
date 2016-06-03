//
//  YHProgressHUD.swift
//  YHProgressHUD
//
//  Created by Detailscool on 16/5/20.
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
        showWindow.frame = CGRect(x: 0, y: -YHProgressHUDStatusBarHeight, width: YHProgressHUDScreenWidth,height: YHProgressHUDStatusBarHeight)
        UIView.animateWithDuration(YHProgressAnimationDuration, animations: {
            showWindow.hidden = false
            showWindow.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 20)
        }) { (_) in
            if let _ = finished {
                finished!()
            }
        }
    }
    
    class func dismiss() {
        UIView.animateWithDuration(YHProgressAnimationDuration, animations: {
            showWindow.frame = CGRect(x: 0, y: -YHProgressHUDStatusBarHeight, width: YHProgressHUDScreenWidth, height: YHProgressHUDStatusBarHeight)
        }) { (_) in
            showWindow.hidden = true
        }
    }
    
    class func showWithStatus(status:String) {
        showWindow.setStatusText(status)
        show(nil)
    }
    
    class func showSuccessWithStatus(status:String,duration:NSTimeInterval = YHProgressDefaultStayDuration) {
        showWindow.setStatusText(status)
        show { () in
            performSelector(#selector(YHProgressHUD.dismiss), withObject: nil, afterDelay: duration)
        }
    }
    
    class func showErroWithStatus(status:String,duration:NSTimeInterval = YHProgressDefaultStayDuration) {
        showWindow.setStatusText(status)
        show { () in
            performSelector(#selector(YHProgressHUD.dismiss), withObject: nil, afterDelay: duration)
        }
    }
    
    class func setStauts(textColor:UIColor = UIColor.whiteColor(),textBackground:UIColor = UIColor.blackColor(),textFont:UIFont = UIFont.systemFontOfSize(17)) {
        showWindow.textFont = textFont
        showWindow.textColor = textColor
        showWindow.bgColor = textBackground
    }
    
    static let showWindow : ShowingWindow = {
        let window = ShowingWindow()
        window.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        return window
    }()
    
    class ShowingWindow: UIWindow {
        
        var bgColor : UIColor = UIColor.blackColor() {
            didSet {
                backgroundColor = bgColor.colorWithAlphaComponent(0.5);
            }
        }
        
        var textColor : UIColor = UIColor.whiteColor() {
            didSet {
                statusLabel.textColor = textColor;
            }
        }
        
        var textFont : UIFont = UIFont.systemFontOfSize(17) {
            didSet {
                statusLabel.font = textFont;
            }
        }
        
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
            let windowManager = WindowManager.sharedManager()
            windowManager.setStatusBarHidden = false
            rootViewController = windowManager
            windowLevel = UIWindowLevelStatusBar
            hidden = true;
            
            addSubview(statusLabel)
            addSubview(iconView)
            
            statusLabel.translatesAutoresizingMaskIntoConstraints = false
            iconView.translatesAutoresizingMaskIntoConstraints = false
            
            addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: statusLabel, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: -10))
            addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        }
        
        private lazy var statusLabel : UILabel = {
            let label = UILabel()
            label.font = self.textFont
            label.textColor = self.textColor
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
    
    class WindowManager : UIViewController {
        
        var setStatusBarHidden : Bool = false {
            didSet {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        
        var setStatusBarStyle : UIStatusBarStyle = UIStatusBarStyle.Default {
            didSet {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        
        private static let sharedInstance = WindowManager()
        
        class func sharedManager() -> WindowManager {
            return sharedInstance
        }
        
        private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        internal override func prefersStatusBarHidden() -> Bool {
            return setStatusBarHidden
        }
        
        internal override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return setStatusBarStyle
        }
    
    }
}

class YHProgressHUD_NavBar: UIView {
    
    var bgColor : UIColor = UIColor.orangeColor() {
        didSet {
            backgroundColor = bgColor;
        }
    }
    
    var textColor : UIColor = UIColor.whiteColor() {
        didSet {
            statusLabel.textColor = textColor;
        }
    }
    
    var textFont : UIFont = UIFont.systemFontOfSize(17) {
        didSet {
            statusLabel.font = textFont;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: -YHProgressHUDNavigationBarHeight, width: YHProgressHUDScreenWidth, height: YHProgressHUDNavigationBarHeight))
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = bgColor;
        addSubview(statusLabel);
        statusLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }
    
    func setStatusText(status:String) {
        statusLabel.text = status
    }
    
    private lazy var statusLabel : UILabel = {
        let label = UILabel()
        label.font = self.textFont
        label.textColor = self.textColor
        label.textAlignment = NSTextAlignment.Center
        label.sizeToFit()
        return label
    }()
}
