//
//  ViewControllerX.swift
//  002 - Credit Card Checkout
//
//  Created by Mark Moeykens on 1/4/17.
//  Copyright © 2017 Moeykens. All rights reserved.
//

import UIKit
import CDAlertView
@IBDesignable
class UIViewControllerX: UIViewController {
    
    @IBInspectable var lightStatusBar: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if lightStatusBar {
                return UIStatusBarStyle.lightContent
            } else {
                return UIStatusBarStyle.default
            }
        }
    }
}



protocol Alertable {
    func showMessage(msg:String,type:CDAlertViewType)
}

extension UIViewController :Alertable {
    
    func showMessage(msg: String, type: CDAlertViewType) {
        DispatchQueue.main.async {
            let alert = CDAlertView(title: "", message: msg, type: type)
            alert.autoHideTime = 1.0 // This will hide alert box after 2.0 seconds
            alert.titleFont = UIFont.init(name:"Tajawal-Medium", size: 15)!
            alert.circleFillColor = .butterscotch
            alert.messageFont = UIFont.init(name:"Tajawal-Medium", size: 15)!
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .init(rotationAngle: .pi)
                alpha = 0
            }
            alert.hideAnimationDuration = 0.44
            alert.show()
        }
    }
}
    

