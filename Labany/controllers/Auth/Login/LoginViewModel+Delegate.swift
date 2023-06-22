//
//  LoginViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
import PKHUD

extension LoginVC:LoginViewModelDelegate {
    
    func gotoSignUp() {
        
    }
    
    func showLoading() {
startLoadingIndicator()
    }
    
    func killLoading() {
stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
   
    func showErrorAlert(error:String){
        
        showErrorAlert(message: error)
    }
    
    func LoginSuccessfully(userData:User) {
        
        AppDelegate.setUserData(user: userData)
        HUD.hide()
        moveToHome()
        print(AppDelegate.setUserData(user: userData))
    }
    
    func moveToHome(){
    let vc = AppStoryboard.TabBar.viewController(viewControllerClass: TabBarVC.self)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
