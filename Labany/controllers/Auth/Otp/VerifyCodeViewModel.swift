//
//  OtpViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/11/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol VerifyCodeViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func VerifyCodeSendSuccessfully(msg:String,otp:String)
    func CheckCodeSuccessfully(msg:String)
}

class VerifyCodeViewModel {
    weak var delegate: VerifyCodeViewModelDelegate?
    init(delegate:VerifyCodeViewModelDelegate?) {
        self.delegate = delegate
    }

     func callVerifyCodeApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
    WebServices.callVerifyCodeApi(parameters: parameters){ [self] (data, error) in
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
            
                
                self.delegate?.VerifyCodeSendSuccessfully(msg: data?.msg ?? "", otp:data?.data?.otp ?? "")
            }
        }
    }
    
    
    func callCheckCodeApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
   WebServices.callCheckCodeApi(parameters: parameters){ [self] (data, error) in
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
               //register succ
            let userData = data?.data
            AppDelegate.setUserData(user: userData)
            UserDefaults.standard.setLoggedIn(value: true)
            UserDefaults.standard.setValue("1", forKey: "isLogin")

            self.delegate?.CheckCodeSuccessfully(msg:data?.msg ?? "")
           }
       }
   }
}
