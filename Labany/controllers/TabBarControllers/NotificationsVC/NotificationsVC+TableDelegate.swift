//
//  NotificationsVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import Foundation
import UIKit
extension NotificationsVC : UITableViewDelegate,UITableViewDataSource {
   
    func setupTableView()
    {
        NotificationTable.delegate = self
        NotificationTable.dataSource = self
        NotificationTable.register(UINib.init(nibName: "NotificationCell", bundle:nil), forCellReuseIdentifier: "cell")
        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if notificationVM.notificatiosArr?.count == nil || notificationVM.notificatiosArr?.count == 0 {
            if MOLHLanguage.isArabic(){
                self.NotificationTable.setEmptyMessage("ليس لديك إشعارات")
            }else{
                self.NotificationTable.setEmptyMessage("You don't have Notifications")
            }
        } else {
            NotificationTable.restore()
            return notificationVM.notificatiosArr?.count ?? 0
        }
        return notificationVM.notificatiosArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationCell
        
        let index = notificationVM.notificatiosArr?[indexPath.row]
        cell.configCell(notifiy: index)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 124
    }
    
    
}
