//
//  EditProfileViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/15/21.
//

import Foundation


extension EditProfileVC : ProfileViewModelDelegate{
    func deletAccountSuccessfully(msg: String?) {
        showMessage(msg: msg ?? "", type: .success)
        AppDelegate.setUserData(user: nil)
        UserDefaults.standard.setLoggedIn(value: false)
        UserDefaults.standard.removeObject(forKey: "isLogin")
        
        reloadRootView()
    }

    
    func logoutSuccessfully(msg: String) {
     //   showSuccessAlert(message: msg)
        showMessage(msg: msg, type: .success)
    }
    
    func logoutSuccessfully() {
        
    }
    
    func editUserDataSuccessfully(name:String, email:String, image:String ) {
        userData?.email = email
        userData?.username = name
        userData?.image = image
        profileVC.userData = userData
        AppDelegate.setUserData(user: profileVC.userData)

        showMessage(msg: "تم تعديل الحساب بنجاح", type: .success)
        self.dismiss(animated: true, completion: nil)

    }
  
    func GetUserDataSuccessfully(user: User?) {
    }
    

    
    func connectionFailed() {
        self.connectionFailedAlert()

    }
    
   
    
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
    }
    
    func reloadRootView() {
       let vc = AppStoryboard.Main.viewController(viewControllerClass: LoginVC.self)
       self.navigationController?.pushViewController(vc, animated: true)
            
   }
    
}
