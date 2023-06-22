//
//  NotificationManger.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 3/31/21.
//

import Foundation
import UserNotifications

enum NotificationName: String {
    case didPaySuccessfully = "PaySuccessfully"
    case didUpdateFamilyOrBusinessAccounts = "UpdateFamilyOrBusinessAccounts"

}

class NotificationsManager {

    //=======================
    //MARK: Post Notification
    //=======================
    static func postNotification(withName name: NotificationName) {
        NotificationCenter.default.post(
            name: Notification.Name(name.rawValue),
            object: nil
        )
    }// postNotification
    
    //==========================
    //MARK: Observe Notification
    //==========================
    static func observeNotification(withName name: NotificationName, observer: Any, selector: Selector) {
        NotificationsManager.removeNotification(observer: observer, withName: name)
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: Notification.Name(name.rawValue),
            object: nil
        )
    }// observeNotification
    
    //=========================
    //MARK: Remove Notification
    //=========================
    static func removeNotification(observer: Any, withName name: NotificationName) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
    }// removeNotification
    
    
    static func notificationRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    static func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    static func showLocalNotification (title: String, body: String, timeInterval: Double?, identifier: String) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
                print("Notification not allowed")
            }
        }
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        //        let date = Date(timeIntervalSinceNow: timeInterval)
        //        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        var trigger: UNTimeIntervalNotificationTrigger?
        if timeInterval != nil {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval!, repeats: false)
        }
        let identifier = identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
