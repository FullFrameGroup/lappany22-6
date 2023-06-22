//
//  ForrgetPasswordavigator.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
import UIKit
extension ChangePasswordVC {
    func headerSetUp()  {
        headerView.lblTitle.text = "تغيير كلمة السر"
        headerView.lblTitle.textColor  = .white
    }
    
    func Validate (){
        if tfOldPassword.text?.isEmpty ?? true
        {
            showMessage(msg: "من فضلك أدخل كلمة المررو ", type: .error)
        }
        else if tfnewPassword.text?.isEmpty ?? true
        {
            showMessage(msg: "من فضلك أدخل كلمة المررو الجديدة", type: .error)
        }
        else if tfConnfirmPassword.text?.isEmpty ?? true
        {
            showMessage(msg: "من فضلك أدخل  تأكيد كلمة المررو", type: .error)
        }
        else if tfnewPassword.text != tfConnfirmPassword.text
        {
            showMessage(msg: "لا يجب أن تكون كلمة المرور الجديدة وكلمة المرور الحالية متطابقة", type: .error)
        }else{
            callApi()
        }
        
    }
    
    func callApi(){
        
        if isConnectedToInternet()
        {
            
        guard let userId = AppDelegate.getUserData()?.id else {return}
            let parameters = ["id":userId,"old_password":tfOldPassword.text!,"new_password":tfnewPassword.text!] as [String : Any]
            btnSave.startAnimation()
            changePasswordVM.callChangePasswordApi(parameters: parameters)
            btnSave.stopAnimation()
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    func Secure1(){
        tfOldPassword.isSecureTextEntry = !tfOldPassword.isSecureTextEntry

        if tfOldPassword.isSecureTextEntry
        {
            btnOldPassSecure
                .setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnOldPassSecure.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }

    
    func Secure2(){
        tfnewPassword.isSecureTextEntry = !tfnewPassword.isSecureTextEntry

        if tfnewPassword.isSecureTextEntry
        {
            btnNewPassSecure
                .setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnNewPassSecure.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }
    
    
    func Secure3(){
        tfConnfirmPassword.isSecureTextEntry = !tfConnfirmPassword.isSecureTextEntry

        if tfConnfirmPassword.isSecureTextEntry
        {
            btnConfirmPassSecure
                .setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
        }else
        {
            btnConfirmPassSecure.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)

        }
    }
}
