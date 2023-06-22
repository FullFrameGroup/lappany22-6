//
//  SplashVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/8/21.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       print(MOLHLanguage.currentAppleLanguage())
        self.navigationController?.navigationBar.isHidden = true
       
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkLogiState()
//        }
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        moveToLogin()
        
    }

    @IBAction func registerAction(_ sender: Any) {
        moveToRegister()
        
    }
    
    @IBAction func Visitor(_ sender: Any) {
       MoveAsVisitor()
        
    }

    
}

