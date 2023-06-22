//
//  Application.swift
//  LocalizationAutomated
//
//  Created by Eman Gaber on 3/15/19.
//  Copyright © 2019 Eman Gaber. All rights reserved.
//

import Foundation
import UIKit

class MyApplication: UIApplication,UIApplicationDelegate {
    
    override open var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        
        get {
            
            if LanguageManager.isCurrentLanguageRTL() {
                
                return .rightToLeft
                
            }else {
                
                return .leftToRight
                
            }
            
        }
    }
    
}
