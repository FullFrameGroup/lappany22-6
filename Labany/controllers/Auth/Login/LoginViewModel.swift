//
//  LoginViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
import PKHUD
import Alamofire
////import SwiftyJSON
import MIAlertController

protocol LoginViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func LoginSuccessfully(userData:User)
    func gotoSignUp()
   
}

class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    init(delegate:LoginViewModelDelegate?) {
        self.delegate = delegate
    }
    

     func callLoginApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
    LoginWebServices.callLoginApi(parameters: parameters){ [self] (data, error) in
        self.delegate?.killLoading()
        
        if error == nil && data == nil {
            print("Connection failed")
            self.delegate?.connectionFailed()

        } else if (error != nil)  {
            
           self.delegate?.showErrorAlert(error: error ?? "")
            
        } else if (data?.success == false){
        self.delegate?.showErrorAlert(error: data?.msg ?? "")
            
        }
            else if (data?.success == true){
                //Login successfully
                UserDefaults.standard.setLoggedIn(value: true)
                UserDefaults.standard.setValue("1", forKey: "isLogin")
                let userData = data?.data
                AppDelegate.setUserData(user: userData)


                self.delegate?.LoginSuccessfully(userData:userData!)
            }
        }

    }
    
    
    func socialLoginApi(parameters: [String : Any]) {
   LoginWebServices.callSocialLoginApi(parameters: parameters){ [self] (data, error) in
       self.delegate?.killLoading()
       
       if error == nil && data == nil {
           print("Connection failed")
           self.delegate?.connectionFailed()

       } else if (error != nil)  {
           
          self.delegate?.showErrorAlert(error: error ?? "")
           
       } else if (data?.success == false){
       self.delegate?.showErrorAlert(error: data?.msg ?? "")
        
        
        
       }
           else if (data?.success == true){
               //phoneRegister succ
            let userData = data?.data
            AppDelegate.setUserData(user: data?.data)

               UserDefaults.standard.setLoggedIn(value: true)
               UserDefaults.standard.setValue("1", forKey: "isLogin")

            self.delegate?.LoginSuccessfully(userData: userData!)
           }
       }

   }
}
