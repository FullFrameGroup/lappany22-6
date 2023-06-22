//
//  LanguageManager.swift
//  LocalizationAutomated
//
//  Created by Ismail AhmedEman Gaber
//  Copyright © 2019 Eman Gaber. All rights reserved.
//

import Foundation
import UIKit
fileprivate var kBundleKey = 0
class BundleEx : Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &kBundleKey) as? Bundle {
            return bundle.localizedString(forKey:key, value:value, table:tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
    }
}

extension Bundle {
    static let once_action : Void = {
        print("executed once")
        object_setClass(Bundle.main, BundleEx.self)
    }()
    static func setLanguage(language : String) {
        Bundle.once_action
        let rtl = LanguageManager.isCurrentLanguageRTL()
        if rtl {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        UserDefaults.standard.set(rtl, forKey: "AppleTextDirection")
        UserDefaults.standard.set(rtl, forKey: "NSForceRightToLeftWritingDirection")
        var tempLanguage = ""
        if language.contains("en"){
            tempLanguage = "en"
        }else{
            tempLanguage = "ar"
        }
        let value = Bundle(path: Bundle.main.path(forResource: tempLanguage, ofType: "lproj")!)
        
        objc_setAssociatedObject(Bundle.main, &kBundleKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

