//
//  SplashNavigator.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation

extension SplashVC {
    
   
    
    func moveToRegister(){
        let vc = AppStoryboard.Main.viewController(viewControllerClass: RegisterVC.self)
        
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    func moveToLogin()
    {
        let vc = AppStoryboard.Main.viewController(viewControllerClass: LoginVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func checkLogiState()
    {

        if UserDefaults.standard.isLoggedIn()
        {
            self.openHomeVC()
        }
        
    }
    
    func openHomeVC()
    {
        let vc = AppStoryboard.TabBar.viewController(viewControllerClass: TabBarVC.self)

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func MoveAsVisitor(){
        
        let vc = AppStoryboard.TabBar.viewController(viewControllerClass: TabBarVC.self)
        General.sharedInstance.tabBar = vc
        UserDefaults.standard.setLoggedIn(value: false)
        UserDefaults.standard.setValue("0", forKey: "isLogin")

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
