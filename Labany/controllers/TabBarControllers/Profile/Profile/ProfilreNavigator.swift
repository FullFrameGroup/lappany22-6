//
// ProfilreNavigator.swift
//  Labany
//
//  Created by Eman Gaber on 7/18/21.
//

import Foundation
import CDAlertView
import Presentr
import LSDialogViewController
import UIKit
extension ProfileVC {
    
    
    func showLogoutAlert(){
        let alert = CDAlertView(title: "", message:"هل تريد تسجيل الخروج", type: .notification)
        
        alert.circleFillColor = #colorLiteral(red: 0.9751031995, green: 0.7038634419, blue: 0.2710191011, alpha: 1)
        
        let yesAction = CDAlertViewAction(title:"نعم") { _ in
            //print("yeeee")
            
                self.LogoutApi()
            
            
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
    
    
    
    func showDeletAccountAlert(){
        let alert = CDAlertView(title: "", message:"هل تريد حذف الحساب من تطبيق لباني  ", type: .notification)
        
        alert.circleFillColor = #colorLiteral(red: 0.9751031995, green: 0.7038634419, blue: 0.2710191011, alpha: 1)
        
        let yesAction = CDAlertViewAction(title:"نعم") { _ in
            //print("yeeee")
            let userId = AppDelegate.getUserData()?.id!
                self.deleteAccoutApi(user_id: userId ?? 0)
            
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
        
        let vc = AppStoryboard.Main.viewController(viewControllerClass: LoginVC.self)
        General.sharedInstance.tabBar?.navigationController?.pushViewController(vc, animated: true)

    }

    func dismissDialog() {
        dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }
    
    
    
    
}

