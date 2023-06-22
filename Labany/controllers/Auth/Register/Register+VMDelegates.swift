//
//  RegisterNavgator.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import PKHUD
import MIAlertController


extension RegisterVC:RegisterViewModelDelegate {
    func connectionFailed() {
        self.connectionFailedAlert()
    }
    
    func showErrorAlert(error: String) {
       
        showErrorAlert(message: error)
    }
    
    func registerSuccessfully(code:Int) {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: PhoneRegisterVC.self)
        vc.id = code
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
 
}
