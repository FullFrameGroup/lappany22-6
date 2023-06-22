//
//  Localizer.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 2/23/21.
//


import Foundation
import UIKit

class Localizer2 {
    class func DoLanguageExchange(withAwakeNib: Bool = true) {
        
         swilizeLocalizedMethod(Bundle.self, originalSelector: #selector(Bundle.localizedString), overrideSelector: #selector(Bundle.customLocalizedStringForKey(_:value:table:)))
        if withAwakeNib {
            methodSwizzleGivenClassName(cls: UIView.self, originalSelector: #selector(UIView.awakeFromNib), overrideSelector: #selector(UIView.newAwakeFromNib))
        }
        methodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.awakeFromNib), overrideSelector: #selector(UITextField.cstmAwakeFromNib))
        methodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.awakeFromNib), overrideSelector: #selector(UILabel.cstmAwakeFromNib))
        methodSwizzleGivenClassName(cls: UITextView.self, originalSelector: #selector(UITextView.awakeFromNib), overrideSelector: #selector(UITextView.cstmAwakeFromNib))
        methodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.awakeFromNib), overrideSelector: #selector(UIButton.cstmAwakeFromNib))
        methodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(setter: UILabel.text), overrideSelector: #selector(UILabel.customSetText(text:)))
        methodSwizzleGivenClassName(cls: UITabBar.self, originalSelector: #selector(UITabBar.awakeFromNib), overrideSelector: #selector(UITextView.cstmAwakeFromNib))

//        methodSwizzleGivenClassName(cls: UIViewController.self, originalSelector: #selector(UIViewController.viewDidDisappear(_:)), overrideSelector: #selector(UIViewController.cstViewDidDisappear(_:)))

//        RequestsHandler.delegate

    }
}

extension UIApplication {
    class func isRTL() -> Bool {
        return Language.currentLanguage() == "ar"
    }
}

extension Bundle{
    @objc func customLocalizedStringForKey(_ key:String ,value:String?,table tableName:String)->String{
           let currentLanguage = Language.currentLanguage()
           var bundel = Bundle()
           if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"){
               bundel = Bundle(path: path)!
           } else{
               let path  = Bundle.main.path(forResource: "Base", ofType: "lproj")
               bundel = Bundle(path: path!)!
           }
           return bundel.customLocalizedStringForKey(key, value: value, table: tableName)
       }
}

extension UIApplication{
    var customuserInterface:UIUserInterfaceLayoutDirection{
        get{
            let direction = UIUserInterfaceLayoutDirection.leftToRight
//            if MOLHLanguage.isArabic() {
//                direction = UIUserInterfaceLayoutDirection.rightToLeft
//            }
            return direction
        }
    }
}

func swilizeLocalizedMethod(_ className:AnyClass,originalSelector:Selector,overrideSelector:Selector){
    let originalMethod:Method =  class_getInstanceMethod(className,originalSelector)!
    let overrideMethod :Method = class_getInstanceMethod(className, overrideSelector)!

    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)){
        class_replaceMethod(className, overrideSelector,method_getImplementation(originalMethod) , method_getTypeEncoding(originalMethod))
    }
    else{
        method_exchangeImplementations(originalMethod, overrideMethod)
    }

}

extension UILabel {
    
    @objc
    public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
        self.text = self.text?.localized
        
//        if MOLHLanguage.isArabic() {
//            var fontName = self.font.fontName
//
//            switch self.font.fontName {
//            case "Montserrat-Bold", "Montserrat-SemiBold":
//                fontName = "Tajawal-Bold"
//            case "Montserrat-Regular":
//                fontName = "Tajawal-Regular"
//            case "Montserrat-Medium":
//                fontName = "Tajawal-Medium"
//            default:
//                print("None of them")
//            }
//            let fontSize = self.font.pointSize
//            self.font = UIFont(name: fontName, size: fontSize)
//        }
        if self.textAlignment == .center { return }
        if MOLHLanguage.isArabic() {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
        self.sizeToFit()
    }
    
    @objc
    func customSetText(text: String) {
        self.customSetText(text: text.localized)
    }
}

//extension UIViewController {
//    @objc
//    public func cstViewDidDisappear(_ animated: Bool) {
//        if !(UIApplication.topViewController() is TimeLineTrackingMapVC) {
//            RequestsHandler.delegate = nil
//        }
//    }
//}

extension UITabBar {
    
    @objc
    public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        self.semanticContentAttribute = MOLHLanguage.isArabic() ? .forceRightToLeft : .forceLeftToRight
    }
    
    @objc
    func customSetText(text: String) {
        self.customSetText(text: text.localized)
    }
}

extension UITextView {
    
    @objc
    public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
        self.text = self.text?.localized
//        if MOLHLanguage.isArabic() {
//            var fontName = self.font?.fontName
//
//            switch self.font?.fontName {
//            case "Montserrat-Bold", "Montserrat-SemiBold":
//                fontName = "Tajawal-Bold"
//            case "Montserrat-Regular":
//                fontName = "Tajawal-Regular"
//            case "Montserrat-Medium":
//                fontName = "Tajawal-Medium"
//            default:
//                print("None of them")
//            }
//            self.font = UIFont(name: fontName ?? "Montserrat-Regular", size: self.font?.pointSize ?? 14)
//        }
        
        if self.textAlignment == .center { return }
        if MOLHLanguage.isArabic() {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }
    
    @objc
    func customSetText(text: String) {
        self.customSetText(text: text.localized)
    }
}

extension UITextField {
    @objc
    public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
        self.text = self.text?.localized
//        if MOLHLanguage.isArabic() {
//            var fontName = self.font?.fontName
//
//            switch self.font?.fontName {
//            case "Montserrat-Bold", "Montserrat-SemiBold":
//                fontName = "Tajawal-Bold"
//            case "Montserrat-Regular":
//                fontName = "Tajawal-Regular"
//            case "Montserrat-Medium":
//                fontName = "Tajawal-Medium"
//            default:
//                print("None of them")
//            }
//            self.font = UIFont(name: fontName ?? "Montserrat-Regular", size: self.font?.pointSize ?? 14)
//        }
        
        if textAlignment == .natural {
            self.textAlignment = .right
        }
        
        if self.textAlignment == .center { return }
        
        if MOLHLanguage.isArabic() {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }
}

extension UIView {
    @objc
    public func newAwakeFromNib() {
        self.newAwakeFromNib()
        self.semanticContentAttribute = MOLHLanguage.isArabic() ? .forceRightToLeft : .forceLeftToRight
    }
}

extension UIButton {
    @objc
    public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        self.setTitle(self.titleLabel?.text?.localized, for: .normal)
//        if MOLHLanguage.isArabic() {
//            var fontName = self.titleLabel?.font?.fontName
//
//            switch self.titleLabel?.font?.fontName {
//            case "Montserrat-Bold", "Montserrat-SemiBold":
//                fontName = "Tajawal-Bold"
//            case "Montserrat-Regular":
//                fontName = "Tajawal-Regular"
//            case "Montserrat-Medium":
//                fontName = "Tajawal-Medium"
//            default:
//                print("None of them")
//            }
//            self.titleLabel?.font = UIFont(name: fontName ?? "Montserrat-Regular", size: self.titleLabel?.font?.pointSize ?? 14)
//        }
        self.titleLabel?.numberOfLines = 0
        if self.contentHorizontalAlignment == .center { return }
        if MOLHLanguage.isArabic() {
            if self.contentHorizontalAlignment == .right { return }
            self.contentHorizontalAlignment = .right
        } else {
            if self.contentHorizontalAlignment == .left { return }
            self.contentHorizontalAlignment = .left
        }
        self.sizeToFit()
    }
}
func methodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!
    if class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    } else {
        method_exchangeImplementations(origMethod, overrideMethod)
    }
}

