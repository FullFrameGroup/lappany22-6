//
//  ResetPasswordNavigator.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
import UIKit
import PKHUD

extension ResetPasswordVC {
    
    func LoginAuth(){
        if  tfPassword.text == "" {
            showMessage(msg: "أدخل كلمةالمرور", type: .error)
        }else if tfConfirmPassword.text  == ""{
            showMessage(msg: "أدخل تأكيد كلمة المرور", type: .error)
        }
        
        
    }
    
    func callApi(id:Int,phone:String){
        
        if isConnectedToInternet()
        {
            let parameters = ["phone":phone,
                              "otp":id,
                              "new_password":"\(tfPassword.text!)"] as [String : Any]
            print(parameters)

            ResetVM.callReSetPassworrdApi(parameters: parameters)

        }else{
            self.showNoInternetAlert()
        }
    }
    
    func Secure1(){
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry

        if tfPassword.isSecureTextEntry
        {
            btnSecure1.setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnSecure1.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }
    func Secure2(){
        tfConfirmPassword.isSecureTextEntry = !tfConfirmPassword.isSecureTextEntry

        if tfConfirmPassword.isSecureTextEntry
        {
            btnSecure2.setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnSecure2.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }
    
    func headerSetUp() {
        headerView.delegate = self
        headerView.lblTitle.text = "إعادة تعيين كلمة المو"
        headerView.lblTitle.textColor  = .white
    }

}

