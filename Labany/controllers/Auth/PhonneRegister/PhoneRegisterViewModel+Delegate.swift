//
//  PhoneRegisterViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/11/21.
//

import Foundation
import PKHUD
import MIAlertController


extension PhoneRegisterVC :PhoneRegViewModelDelegate {
   
    func connectionFailed() {
        self.connectionFailedAlert()
    }

    func showErrorAlert(error: String) {

        showErrorAlert(message: error)
    }

    func phoneRegisterSuccessfully()
    {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: VerifyCodeVC.self)
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func Successfully(id:Int){
        let vc = AppStoryboard.Main.viewController(viewControllerClass: VerifyCodeVC.self)
        
        vc.fromForrget = true
        vc.id = id
        vc.phone = tfPhone.text!
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

