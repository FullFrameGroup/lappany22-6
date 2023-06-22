//
//  Language.swift
//  MySons
//
//  Created by Elsayed Hussein on 11/10/16.
//  Copyright © 2016 Elsayed Hussein. All rights reserved.
//

import Foundation
import UIKit
class Language{
    static let userDefaults = UserDefaults.standard
    class func currentLanguage() -> String {
        let lang = userDefaults.object(forKey: "AppleLanguages") as! NSArray
        let currentLanguage = lang.firstObject as! String
        return currentLanguage
        
    }
    class func setAppLanguage(_ language:String){
        userDefaults.set([language,currentLanguage()], forKey: "AppleLanguages")
        userDefaults.synchronize()
    }

    class var currentLanguageCode: String {
        return MOLHLanguage.isArabic() ? "ar":"en"
    }
    
    class func changeLanguages() {
        if currentLanguage() == "ar"{
            setAppLanguage("en-US")
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else{
            setAppLanguage("ar")
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft

        }
        
    }
    
    

    class func localizeStringForKey(_ word:String)->String{
        let localizedWord = NSLocalizedString(word, comment: "@bokhaey")
        return localizedWord
    }
}
