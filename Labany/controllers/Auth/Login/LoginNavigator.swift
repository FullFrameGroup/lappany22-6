//
//  LoginNavigator.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import UIKit


extension LoginVC{
    
    func MoveToforrgetPassword(){
        let vc = AppStoryboard.Main.viewController(viewControllerClass: PhoneRegisterVC.self)
        vc.fromForrget = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    func moveToRegister(){
        let vc = AppStoryboard.Main.viewController(viewControllerClass: RegisterVC.self)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    func LoginAuth(){
    guard checkIfNotEmpty(for: [tfPhone,tfPassword]) else {return}
       
        
        if UserDefaults.standard.value(forKey:"DeviceToken") == nil {
            mobileToken = ""
        } else {
            mobileToken = UserDefaults.standard.value(forKey:"DeviceToken") as? String ?? ""
        }
       // let deviceIdString = UUID().uuidString
        
        
        if isConnectedToInternet()
        {
            let email = tfPhone.text!.addingPercentEncoding( withAllowedCharacters: .urlFragmentAllowed) ?? ""
           print(email)
            
            let parameters = ["userDetail":email,"password":tfPassword.text!,"device_token": mobileToken,"os_version":"iOS"] as [String : Any]
            loginVM.callLoginApi(parameters: parameters)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    

    func callSocialApi(){
        
        if isConnectedToInternet()
        {
            let parameters = ["userDetail":tfPhone.text!,"device_token": mobileToken,"os_version":"iOS"] as [String :Any]
            loginVM.socialLoginApi(parameters: parameters)
        }else{
            self.showNoInternetAlert()
        }
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

    func currentAppBuild() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return version
        }
        return ""
    }
    
    func currentAppVersion() -> String {
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return ""
    }

    
}

