//
//  ProfileViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/15/21.
//

import Foundation

import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol ProfileViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserDataSuccessfully(user:User?)
    func editUserDataSuccessfully(name:String, email:String, image:String)
    func logoutSuccessfully(msg:String)
    func deletAccountSuccessfully(msg:String?)
    
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    init(delegate:ProfileViewModelDelegate?) {
        self.delegate = delegate
    }
    
    
    func getProfileDataApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
        ProfileWebService.getUserDatasApi(parameters: parameters){ [self] (data, error) in
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
                
                self.delegate?.GetUserDataSuccessfully(user:(data?.data!)!)
                
            }
        }
        
    }
    
     func callEditProfileApi(parameters: [String : Any],image:UIImage?){
        self.delegate?.showLoading()

        NetworkRequest.callUpdateProfile(Url:APIs.Instance.editUserDataUrl(), userImage:image , params: parameters) { (result, _ message,userName,email,image ) in
            self.delegate?.killLoading()

            if result == true {
                
                self.delegate?.editUserDataSuccessfully(name:userName, email:email, image:image )
                
                
            }else
            {
              
                self.delegate?.showErrorAlert(error: "فشل في تعديل الحساب")
                
            }
            
        }
    }

    func callLogoutApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
        ProfileWebService.logoutApi(parameters: parameters){ [self] (data, error) in
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
                //Logout Success
                AppDelegate.deleteUserData()
                
                self.delegate?.logoutSuccessfully(msg:data?.msg ?? "")
                
            }
        }
        
    }
    
    
    func getDeleteAccountApi(user_id:Int) {
        self.delegate?.showLoading()
        ProfileWebService.deleteAccountApi(user_id:user_id){ [self] (data,error) in
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
        
        
       
           self.delegate?.deletAccountSuccessfully(msg: data?.msg ?? "")
        
       }

}
}
    
}
