//
//  Navigator.swift
//  Labany
//
//  Created by Eman Gaber on 8/7/21.
//

import Foundation
import UIKit
import CDAlertView
extension ProductDetailVC {
    
    func showLoginAlert(){
        let alert = CDAlertView(title: "", message:"يجب تسجيل  الدخول أولاً", type: .notification)
        
        alert.circleFillColor = #colorLiteral(red: 0.9751031995, green: 0.7038634419, blue: 0.2710191011, alpha: 1)
        
        let yesAction = CDAlertViewAction(title:"نعم") { _ in
            //print("yeeee")
            
                self.login()
            
            
            return true
        }
        yesAction.buttonTextColor = .label
        
        
        let noAction = CDAlertViewAction(title:"لا") { _ in
            //print("nooooo")
            return true
        }
        noAction.buttonTextColor = .label
        alert.add(action: yesAction)
        alert.add(action: noAction)
        alert.show()
    }
    func login(){
        dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("dismissToLogin"),object: nil,userInfo:nil )
        }
        
        self.navigationController?.popViewController(animated: true)

    }
}
