//
//  RegisterEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol ResetPasswordViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func resetPasswordSuccessfully()
   
}

class ResetPassViewMode {
    weak var delegate: ResetPasswordViewModelDelegate?
    init(delegate:ResetPasswordViewModelDelegate?) {
        self.delegate = delegate
    }
    
    
    func callReSetPassworrdApi(parameters: [String : Any]) {
        ResetPassWebServices.callResetPassApi(parameters: parameters){ [self] (data, error) in
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
               let id = data?.data?.id
               UserDefaults.standard.set(id, forKey: "User_Id")

               self.delegate?.resetPasswordSuccessfully()
               
           }
       }

    }
    

}
