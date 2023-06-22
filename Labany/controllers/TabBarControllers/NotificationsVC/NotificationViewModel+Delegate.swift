//
//  NotificationViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
import UIKit
extension NotificationsVC: NotificationViewModelDelegate{
    
    func GetUserNotificationsSuccessfully(notification: [Notifications]) {
        if notification.count == 0  {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3){
                self.noNotificationsView.isHidden = false
            }
        }else{
            self.NotificationTable.isHidden = false
            self.NotificationTable.reloadData()
            self.NotificationTable.showLoader()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
                self.NotificationTable.reloadData()
                self.noNotificationsView.isHidden = true
        }
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showErrorAlert(error:String){
        showErrorAlert(message: error)
    }
    
    @objc func removeLoader()
    {
        self.NotificationTable.hideLoader()
    }

}
