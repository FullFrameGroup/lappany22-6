//
//  RegisterUI.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
import UIKit

extension RegisterVC {
   
    func SetpupUI(){
        headerView.delegate = self
        headerView.lblTitle.text =  "تسجيل حساب"
        tfUserName.textAlignment = .right
        tfEmail.textAlignment = .right
        tfPassword.textAlignment = .right
        tfConfirmPassword.textAlignment = .right
    }
    
    
    
    func Secure(){
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry

        if tfPassword.isSecureTextEntry
        {
            btnSecure.setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnSecure.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }
    
    func Secure2(){
        tfConfirmPassword.isSecureTextEntry = !tfConfirmPassword.isSecureTextEntry

        if tfPassword.isSecureTextEntry
        {
            btnSecure2.setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnSecure2.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }
    
}
