//
//  SceneDelegate.swift
//  PerfectWorker
//
//  Created by Eman Gaber on 4/25/22.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        
        print("url: \(url)")
        if url.scheme?.caseInsensitiveCompare("com.aait.nokhba2") == .orderedSame {
            NotificationsManager.postNotification(withName: .didPaySuccessfully)
        }
        
        
        ApplicationDelegate.shared.application(
              UIApplication.shared,
              open: url,
              sourceApplication: nil,
              annotation: [UIApplication.OpenURLOptionsKey.annotation]
          )
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //newww when app closed
        if connectionOptions.notificationResponse != nil{
            let userInfoo = connectionOptions.notificationResponse!.notification.request.content.userInfo as NSDictionary
            
                handleRemoteNotification(userInfo: userInfoo)
        }

        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    
    func handleRemoteNotification(userInfo:NSDictionary){
            
        
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
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

