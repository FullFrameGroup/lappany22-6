//
//  NotificationViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol NotificationViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserNotificationsSuccessfully(notification:[Notifications])
}

class NotificationViewModel {
    weak var delegate: NotificationViewModelDelegate?
    init(delegate:NotificationViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var notificatiosArr:[Notifications]?
    
    
    func getUserNotificationsApi(user_id:Int) {
        self.delegate?.showLoading()
        NotificationsWebServices.getNotificationsApi(user_id:user_id){ [self] (data, error) in
   self.delegate?.killLoading()
   
   if error == nil && data == nil {
       print("Connection failed")
       self.delegate?.connectionFailed()

   } else if (error != nil)  {
       
      self.delegate?.showErrorAlert(error: error ?? "")
       
   } else if (data?.success == false){
   self.delegate?.showErrorAlert(error: data?.msg ?? "")
       
   }
       else if (data?.code == 200){
           //phoneRegister succ
        notificatiosArr = data?.data?.notification
    self.delegate?.GetUserNotificationsSuccessfully(notification:notificatiosArr ?? [])
        
       }

}
}
}
