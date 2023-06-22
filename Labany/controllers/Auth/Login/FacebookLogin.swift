//
//  FacebookLogin.swift
//  Labany
//
//  Created by Mac on 16/08/2021.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

extension LoginVC{
    
   
    func facebookLogin() {
            
           // ApplicationDelegate.initializeSDK(nil)
            
            let fbLoginManager = LoginManager()
            fbLoginManager.logOut()
            fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                
                if error != nil { return }
                
                if let token = AccessToken.current,
                   !token.isExpired {
                    // User is logged in, do work such as go to next view controller.
                    let providerID = AccessToken.current?.userID
                    print(providerID!)
                    self.getFBUserData()
                }
            }
        }
    
    func getFBUserData(){
           
           if((AccessToken.current) != nil){
               //,public_profile
               GraphRequest(graphPath: "me", parameters: ["fields": "email,first_name,last_name"]).start { (connection, result, error) -> Void in
                   if (error == nil){
                       
                       guard let info = result as? [String: Any] else { return }
                       let providerID = AccessToken.current?.userID
                       print(providerID!)
                       
                      //  Get user profile pic
//                       let pictureLink = "http://graph.facebook.com/\(providerID!)/picture?type=large"
//                    _ = NSURL(string:pictureLink)
                    
                       //print("user profile pic : \(pictureLink)")
                    // Get user profile pic
                    let url = NSURL(string: "http://graph.facebook.com/\(providerID!)/picture?type=large")
                    print("user profile pic : \(url!)")
                    
                    //   let urlRequest = NSURLRequest(url: url! as URL)
                    self.userimageURL = "http://graph.facebook.com/\(providerID!)/picture?type=large"
                    
                       let fb_FirstName = info["first_name"] as? String
                       let fb_LastName = info["last_name"] as? String
                       let email = info["email"] as! String
                       let fullame = "\(fb_FirstName ?? "") \(fb_LastName ?? "")"
                       
                    UserDefaults.standard.setValue(email, forKey: "fb_email")
                    UserDefaults.standard.setValue(fullame, forKey: "fb_username")
                    UserDefaults.standard.setValue(self.userimageURL, forKey: "fb_img")

                    self.showSuccessAlert(message: "Login_success".localized)
                       
                       if UserDefaults.standard.value(forKey:"DeviceToken") == nil {
                           self.mobileToken = ""
                       } else {
                           self.mobileToken = UserDefaults.standard.value(forKey:"DeviceToken") as? String ?? ""
                       }
                      // let deviceIdString = UUID().uuidString
                    
                    if self.isConnectedToInternet()
                    {
                        let parameters = ["userDetail":email,"mobileToken": self.mobileToken,"os_version":"iOS","username":fullame] as [String : Any]
                        self.loginVM.socialLoginApi(parameters: parameters)
                    }else{
                        self.showNoInternetAlert()
                    }
                   }
                   else{
                    self.showErrorAlert(message: "Sorry please try once again")
                   }
               }
               
           }
           
       }
    
}


