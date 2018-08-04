//
//  AppHelper.swift
//  PSIIndexSG
//
//  Created by klooma developer on 04/08/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit

class AppHelper: NSObject {
    private var loadingViewContainer: UIView?
    
    func showLoading(msg: String) {
        if loadingViewContainer == nil {
            let screenBounds = UIScreen.main.bounds
            let window = UIApplication.shared.keyWindow
            
            loadingViewContainer = UIView(frame: screenBounds)
            loadingViewContainer?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activity.center = CGPoint(x: screenBounds.size.width/2, y: screenBounds.size.height/2)
            activity.startAnimating()
            loadingViewContainer?.addSubview(activity)
            
            let msgLbl = UILabel(frame: CGRect(x: 15, y: (screenBounds.size.height/2) + 20, width: screenBounds.size.width - 30, height: 100))
            msgLbl.text = msg
            msgLbl.numberOfLines = 0
            msgLbl.textAlignment = .center
            msgLbl.lineBreakMode = .byWordWrapping
            msgLbl.font = UIFont.systemFont(ofSize: 14)
            msgLbl.textColor = UIColor.white
            
            loadingViewContainer?.addSubview(msgLbl)
            window?.addSubview(loadingViewContainer!)
        }
    }
    
    func showLoadingInView(view: UIView, msg: String) {
        if loadingViewContainer == nil {
            let screenBounds = UIScreen.main.bounds
            let window = UIApplication.shared.keyWindow
            
            loadingViewContainer = UIView(frame: screenBounds)
            loadingViewContainer?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activity.center = CGPoint(x: screenBounds.size.width/2, y: screenBounds.size.height/2)
            activity.startAnimating()
            loadingViewContainer?.addSubview(activity)
            
            let msgLbl = UILabel(frame: CGRect(x: 15, y: (screenBounds.size.height/2), width: screenBounds.size.width - 30, height: 100))
            msgLbl.text = msg
            msgLbl.numberOfLines = 0
            msgLbl.textAlignment = .center
            msgLbl.lineBreakMode = .byWordWrapping
            msgLbl.font = UIFont.systemFont(ofSize: 14)
            msgLbl.textColor = UIColor.white
            
            loadingViewContainer?.addSubview(msgLbl)
            window?.addSubview(loadingViewContainer!)
        }
    }
    
    func endLoading() {
        do {
            if loadingViewContainer != nil {
                loadingViewContainer?.removeFromSuperview()
            }
        } catch {
            
        }
        
        loadingViewContainer = nil
    }
}
