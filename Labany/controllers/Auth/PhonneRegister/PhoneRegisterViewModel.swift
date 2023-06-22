//
//  PhoneRegisterViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/11/21.
//

import Foundation
import PKHUD
import Alamofire
////import SwiftyJSON
import MIAlertController

protocol PhoneRegViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func phoneRegisterSuccessfully()
    func  Successfully(id:Int)
}

class PhoneRegisterViewModel {
    weak var delegate: PhoneRegViewModelDelegate?
    init(delegate:PhoneRegViewModelDelegate?) {
        self.delegate = delegate
    }
    

     func callPhoneregisterApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
    PhoneRegisterWebServices.phoneRegisterApi(parameters: parameters){ [self] (data, error) in
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
                
                self.delegate?.phoneRegisterSuccessfully()
            }
        }

    }
    
    
    func callForgetPasswordApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
   PhoneRegisterWebServices.callForrgetPassApi(parameters: parameters){ [self] (data, error) in
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
            
            let id = data?.data?.id
               self.delegate?.Successfully(id: id!)
           }
       }

   }
}
