//
//  UIViewController.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit
extension UIViewController{
    
    typealias CompletionHandlerConfirmExit = () -> Void
    
    /**********************Alert View*******************/
    
    func showAlertViewInSuperview(_ Title:String, message:String , completion:@escaping () -> Void)  {
        
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default,  handler: { action in
            alertController.dismiss(animated: true, completion: completion) })
        
        alertController.addAction(defaultAction)
        
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }
    
    /**********************Activity Indicator*******************/
    
    func showActivityIndicatoryInSuperview() {
        
        let window = UIApplication.shared.keyWindow!
        let loadingView = LoadingView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
        //        loadingView.
        window.addSubview(loadingView)
        objc_setAssociatedObject(UIApplication.shared.keyWindow?.rootViewController! as Any, &ActivityIndicatorViewInSuperviewAssociatedObjectKey, loadingView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    func hideActivityIndicatoryInSuperview()  {
        
        if let ActivityIndicatory = objc_getAssociatedObject(UIApplication.shared.keyWindow?.rootViewController as Any, &ActivityIndicatorViewInSuperviewAssociatedObjectKey) {
            
            (ActivityIndicatory as AnyObject).removeFromSuperview()
            
        }
        
    }
    
}
