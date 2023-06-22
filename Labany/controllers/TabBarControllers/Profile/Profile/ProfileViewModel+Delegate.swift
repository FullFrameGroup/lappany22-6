//
//  ProfileViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/15/21.
//

import Foundation
import UIKit

extension ProfileVC : ProfileViewModelDelegate{
    func deletAccountSuccessfully(msg: String?) {
        showMessage(msg: msg ?? "" , type: .success)
        AppDelegate.setUserData(user: nil)
        UserDefaults.standard.setLoggedIn(value: false)
        UserDefaults.standard.removeObject(forKey: "isLogin")
        reloadRootView()
    }
    
    
    
    func editUserDataSuccessfully(name:String, email:String, image:String) {
        userData?.image = image
        userData?.username  = name
        userData?.email = email
    }
    
    func GetUserDataSuccessfully(user: User?) {
        userData = user
        setDataInView()
        lblWalletAmount.text! =  "\(userData?.wallet_amount  ?? 0)" + "ر.س"

    }
    
    func setDataInView()
    {
        if (userData?.image ?? "") !=  "" {
            imgProfile.sd_setImage(with: URL.init(string:userData?.image ?? ""))
            let encodedImg = userData?.image ?? "".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""

            Helper.loadImage(url:encodedImg , image: self.imgProfile)
            self.imgProfile.contentMode = .scaleAspectFit

            
        }
        lblUserName.text! = userData?.username ?? ""
        lblUserEmail.text! = userData?.email ?? ""
        lblWalletAmount.text = "\( userData?.wallet_amount ?? 0 )" + "ريال "
    }
    
    func connectionFailed() {
        self.connectionFailedAlert()

    }
    
   
    
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
    }
    
    
    func logoutSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)
        AppDelegate.setUserData(user: nil)
        UserDefaults.standard.setLoggedIn(value: false)
        UserDefaults.standard.removeObject(forKey: "isLogin")
        
        reloadRootView()
    }
    
    func deletAccountSuccessfully(msg:String){
        showMessage(msg: msg, type: .success)
        AppDelegate.setUserData(user: nil)
        UserDefaults.standard.setLoggedIn(value: false)
        UserDefaults.standard.removeObject(forKey: "isLogin")
        reloadRootView()
        
    }
    
     func reloadRootView() {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: LoginVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
             
    }
    
}
