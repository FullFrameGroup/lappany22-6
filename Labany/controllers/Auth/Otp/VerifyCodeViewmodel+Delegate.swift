//
//  OtpViewmodel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/11/21.
//

import Foundation
import PKHUD
extension VerifyCodeVC :VerifyCodeViewModelDelegate {
   
    
    func VerifyCodeSendSuccessfully(msg: String,otp:String) {
        let message = msg + "\(otp)"
        showMessage(msg:  message, type: .success)
        self.otp = otp
    }
    
    func showLoading() {
startLoadingIndicator()
    }
    
    func killLoading() {
stopLoadingIndicator()
    }

    func connectionFailed() {
        self.connectionFailedAlert()
    }

    func showErrorAlert(error: String) {

        showErrorAlert(message: error)
    }

    
    func CheckCodeSuccessfully(msg:String){
        showMessage(msg: msg, type: .success)

        if fromForrget == true {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3){
                self.openRestPassVC()
            }
        }else{
            UserDefaults.standard.setLoggedIn(value: true)
            UserDefaults.standard.setValue("1", forKey: "isLogin")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3){
                self.openHomeVC()
            }
        }

        
        
    }
    
    
    
    func openHomeVC()
    {
     
        let vc = AppStoryboard.TabBar.viewController(viewControllerClass: TabBarVC.self)

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func openRestPassVC()
    {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: ResetPasswordVC.self)
        vc.phone = self.phone
        vc.otp = self.otp
        self.navigationController?.pushViewController(vc, animated: true)

        
        
    }

}
