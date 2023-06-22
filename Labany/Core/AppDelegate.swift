//
//  AppDelegate.swift
//  PerfectWorker
//
//  Created by Eman Gaber on 4/25/22.
//

import UIKit
import netfox
import LanguageManager_iOS
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import UserNotifications
import ListPlaceholder
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    var isAppInBackground:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        FBSDKCoreKit.ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        
        IQKeyboardManager.shared.enable = true
       
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "تم"
            IQKeyboardManager.shared.toolbarNextBarButtonItemText = "التالي"
            IQKeyboardManager.shared.toolbarPreviousBarButtonItemText = "السابق"
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        LanguageManager.currentLanguage = AppLanguages.en.rawValue
        
        IQKeyboardManager.shared.enable = true
        // Uncomment the below line for enable Shake functionality
        //NFX.sharedInstance().start()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if Messaging.messaging().fcmToken != nil {
            Messaging.messaging().subscribe(toTopic: "all")
        }

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
        let signInConfig = GIDConfiguration(clientID: "659471893273-u2b8koei9eftrlgpj7ihqch2hbhd3s48.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
            // Show the app's signed-in state.
          }
        }
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }

    
    

    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs token retrieved: \(token)")
        
        Messaging.messaging().apnsToken = deviceToken

    }
    

    
    func registerForNotifications() {
        // Register for notification: This will prompt for the user's consent to receive notifications from this app.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
    }
    
    
    
    // MARK: - Push notification
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                granted, error in
                print("Permission granted: \(granted)") // 3
            }
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
                        @escaping (UIBackgroundFetchResult) -> Void) {
        
        UIViewController().viewWillAppear(true)
    }
    
    
 
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    UIApplication.shared.applicationIconBadgeNumber = 0
}
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    //let bundleIdentifier = Bundle.main.bundleIdentifier
    let urlStr = String(format: "%@", url as CVarArg)
    if urlStr.contains("com.kalp.nokhba"){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        return true
    }
    if url.host == "page"{
        return true
    }
    return false
}


func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    // 1. Convert device token to string
    let tokenParts = deviceToken.map { data -> String in
        return String(format: "%02.2hhx", data)
    }
    let token = tokenParts.joined()
    // 2. Print device token to use for PNs payloads
    print("Device Token: \(token)")
    //let bundleID = Bundle.main.bundleIdentifier
    //print("Bundle ID: \(bundleID ?? "") ");

    // 3. Save the token to local storeage and post to app server to generate Push Notification. ...
}

func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    
    print("failed to register for remote notifications: \(error.localizedDescription)")
    UserDefaults.setUserInfo(value:"" as AnyObject, key: UserDefaultsKey.deviceToken)
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    
    print("Received push notification: \(userInfo)")
    let aps = userInfo["aps"] as! [String: Any]
    print("\(aps)")
   handleRemoteNotification(application: application, userInfo: userInfo as NSDictionary)
}

internal func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     willPresent notification: UNNotification,
                                     withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //Newww handle push while app is in the foreground

    let userInfo = notification.request.content.userInfo as NSDictionary
    print(userInfo)
    handleRemoteNotification(application: UIApplication.shared, userInfo:userInfo)

    let orderStatusNo : String = userInfo["order_status_id"] as? String ?? ""
    let orderId : String = userInfo["order_id"] as? String ?? ""
    
    let message : [String : Any] = userInfo["aps"] as? [String : Any] ?? [:]
    let badge : Int = message["badge"] as? Int ?? 0
    
    let messageAlert : [String : Any] = message["alert"] as?  [String : Any] ?? [:]
    let lBody : String = userInfo["body"] as? String ?? ""
    let lTitle : String = messageAlert["title"] as? String ?? ""
    
    print("OrderId = \(orderId)")
    print("Order Status Number = \(orderStatusNo)")
    print("badge = \(badge)")
    print("body = \(lBody)")
    print("title = \(lTitle)")
}

func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //Newww when app in background

    handleRemoteNotification(application: UIApplication.shared, userInfo: response.notification.request.content.userInfo as NSDictionary)
}


func handleRemoteNotification(application:UIApplication,userInfo:NSDictionary){
        
    
    if userInfo.value(forKey: "aps") != nil{

        if let apsDict = userInfo.value(forKey: "aps") as? NSDictionary{

            if apsDict["alert"] != nil{

                if let alertDict = apsDict.value(forKey: "alert") as? NSDictionary{

                    if let type = alertDict.value(forKeyPath: "type") as? String{

                        if type == "feedback"{

                            if let orderid = alertDict.value(forKeyPath: "order_id") as? String{

                                /*let reviewVC = makeStoryObj(storyboard: storyboardMain, Identifier: "ReviewQuestionViewController") as! ReviewQuestionViewController
                                 reviewVC.order_id = orderid*/

                                if orderid.count != 0{
                                    let data = ["order_id":orderid] as [String : Any]
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushToReviewController"), object: nil, userInfo: data)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


extension AppDelegate : MessagingDelegate {
func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?)
    {
        print("Firebase registration token: \(fcmToken ?? "")")
      
      let def = UserDefaults.standard
      def.setValue(fcmToken, forKey: "DeviceToken")
      def.synchronize()
    }
}



enum AppLanguages:String{
    case en = "en"
    case ar = "ar"
}
