//
//  RegisterNavgator.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import PKHUD
import MIAlertController


extension ResetPasswordVC:ResetPasswordViewModelDelegate {
 
    
    func connectionFailed() {
        self.connectionFailedAlert()
    }
    
    func showErrorAlert(error: String) {
       
        showErrorAlert(message: error)
    }
    
    func resetPasswordSuccessfully() {
        
        let vc = AppStoryboard.Main.viewController(viewControllerClass: LoginVC.self)
        self.navigationController?.pushViewController(vc, animated: true)

    }
 
}
