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

protocol RegisterViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func registerSuccessfully(code:Int)
   
}

class RegisterViewModel {
    weak var delegate: RegisterViewModelDelegate?
    init(delegate:RegisterViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func callRegisterApi(parameters: [String : Any], image:UIImage?) {
       
        self.delegate?.showLoading()
        NetworkRequest.callRegister(Url:APIs.Instance.registerUrl(), userImage:image , params: parameters) { (result, _ message,userId ) in
            self.delegate?.killLoading()

            if result == true {
                
                UserDefaults.standard.set(userId, forKey: "User_Id")

                self.delegate?.registerSuccessfully(code:userId)
                
            }else
            {
              
                self.delegate?.showErrorAlert(error: "فشل في تسجيل الحساب")
                
                
            }
            
        }
    }

}
