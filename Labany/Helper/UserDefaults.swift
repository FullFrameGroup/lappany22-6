//
//  UserDefaults.swift
//  Labany
//
//  Created by Eman Gaber on 7/18/21.
//

import Foundation
import SwiftyJSON

extension UserDefaults
{
    
    

    func setBranch(value: JSON)
    {
        set(value.rawString(), forKey: UserDefaultsKeys.branch.rawValue)
//        let data = NSKeyedArchiver.archivedData(withRootObject: value)
//        set(data, forKey: UserDefaultsKeys.branch.rawValue)
    }

    func getBranch() -> JSON?
    {
        guard let result = string(forKey: UserDefaultsKeys.branch.rawValue) else
        {
            return nil
        }

        if result != ""
        {
            if let json = result.data(using: String.Encoding.utf8, allowLossyConversion: false)
            {
                do
                {
                    return try JSON(data: json)
                }
                catch
                {
                    return nil
                }
            }
            else
            {
                return nil
            }
        }
        else
        {
            return nil
        }
    }

    /*{
        guard let branch = data(forKey: UserDefaultsKeys.branch.rawValue) else
        {
            return nil
        }

        do
        {
            if let json = try JSONSerialization.jsonObject(with: branch, options: []) as? JSON
            {
                return json
            }
            else
            {
                return nil
            }
        }
        catch let error as NSError
        {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }*/
    
    
    
    
    

    func clearUserDefaults()
    {
        let domain = Bundle.main.bundleIdentifier!
        self.removePersistentDomain(forName: domain)
        self.synchronize()
    }
    
    // MARK: - Get-Set NSUserDefaults Global Value
    class func setUserInfo(value : AnyObject?  , key : String)
    {
        let defaults = UserDefaults.standard
        if (value != nil){
            defaults.set(value, forKey: key)
        }
        defaults.synchronize()
    }
    
    class func getUserInfo(key : String) -> AnyObject?
    {
        let defaults = UserDefaults.standard
        if let name = defaults.value(forKey: key){
            return name as AnyObject?
        }
        return nil
    }
    

    func setVoipToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.voipToken.rawValue)
    }

    func getVoipToken() -> String
    {
        guard string(forKey: UserDefaultsKeys.voipToken.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.voipToken.rawValue)!
    }


    func setProfilePic(value: String)
    {
        set(value, forKey: UserDefaultsKeys.profilePic.rawValue)
    }

    func getProfilePic() -> String
    {
        guard string(forKey: UserDefaultsKeys.profilePic.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.profilePic.rawValue)!
    }


    func setCountryCode(value: String)
    {
        set(value, forKey: UserDefaultsKeys.countryCode.rawValue)
    }

    func getCountryCode() -> String
    {
        guard string(forKey: UserDefaultsKeys.countryCode.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.countryCode.rawValue)!
    }

    func setLatitude(value: String)
    {
        set(value, forKey: UserDefaultsKeys.latitude.rawValue)
    }

    func getLatitude() -> String
    {
        guard string(forKey: UserDefaultsKeys.latitude.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.latitude.rawValue)!
    }


    func setLongitude(value: String)
    {
        set(value, forKey: UserDefaultsKeys.longitude.rawValue)
    }

    func getLongitude() -> String
    {
        guard string(forKey: UserDefaultsKeys.longitude.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.longitude.rawValue)!
    }

    func setUserId(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
    }

    func getUserId() -> String
    {
        guard string(forKey: UserDefaultsKeys.userID.rawValue) != nil  else
        {
            return "0"
        }
        return string(forKey: UserDefaultsKeys.userID.rawValue)!
    }

    func setName(value: String)
    {
        set(value, forKey: UserDefaultsKeys.name.rawValue)
    }

    func getName() -> String
    {
        guard string(forKey: UserDefaultsKeys.name.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.name.rawValue)!

    }

    func setLoggedIn(value: Bool)
    {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    func isLoggedIn()-> Bool
    {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    func setEmailId(value: String)
    {
        set(value, forKey: UserDefaultsKeys.emailId.rawValue)
    }

    func getEmailId() -> String
    {
        guard string(forKey: UserDefaultsKeys.emailId.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.emailId.rawValue)!
    }

    func setFirstName(value: String)
    {
        set(value, forKey: UserDefaultsKeys.firstName.rawValue)
    }

    func getFirstName() -> String
    {
        guard string(forKey: UserDefaultsKeys.firstName.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.firstName.rawValue)!

    }

    func setLastName(value: String)
    {
        set(value, forKey: UserDefaultsKeys.lastName.rawValue)
    }

    func getLastName() -> String
    {
        guard string(forKey: UserDefaultsKeys.lastName.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.lastName.rawValue)!

    }
    
    func setAddress(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userAddress.rawValue)
    }
    func getAddress() -> String
    {
        guard string(forKey: UserDefaultsKeys.userAddress.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.userAddress.rawValue)!

    }

    func setMobileNo(value: String)
    {
        set(value, forKey: UserDefaultsKeys.mobileNo.rawValue)
    }

    func getMobileNo() -> String
    {
        guard string(forKey: UserDefaultsKeys.mobileNo.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mobileNo.rawValue)!

    }

    func setAccessToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }
    
    

    func getAccessToken() -> String
    {
        guard let accessToken = string(forKey: UserDefaultsKeys.accessToken.rawValue)
            else
        {
            return ""
        }
        return accessToken
    }

    func setUserImage(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userImage.rawValue)
    }

    func getUserImage() -> String
    {
        guard let accessToken = string(forKey: UserDefaultsKeys.userImage.rawValue)
            else
        {
            return ""
        }
        return accessToken
    }

    func setRating(value: Double)
    {
        set(value, forKey: UserDefaultsKeys.rating.rawValue)
    }

    func getRating() -> Double
    {
        return double(forKey: UserDefaultsKeys.rating.rawValue)
    }

//    func setLanguage(value: Language)
//    {
//        set(value.rawValue, forKey: UserDefaultsKeys.language.rawValue)
//    }

    func getLanguage() -> String?
    {

        guard let language = string(forKey: UserDefaultsKeys.language.rawValue)
            else
        {
            return ""
        }
        return language



//        guard let lang = Language(rawValue: UserDefaultsKeys.language.rawValue)
//            else
//        {
//            return nil
//        }
//        return lang
    }


/*
    func setUserName(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userName.rawValue)
    }

    func getUserName() -> String
    {
        guard string(forKey: UserDefaultsKeys.userName.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.userName.rawValue)!

    }

    func setUserID(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
    }

    func getUserID() -> String
    {
        guard string(forKey: UserDefaultsKeys.userID.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.userID.rawValue)!
    }

    func setAccessToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }

    func getAccessToken() -> String
    {
        guard let accessToken = string(forKey: UserDefaultsKeys.accessToken.rawValue)
        else
        {
            return ""
        }
        return accessToken
    }

    func setEmailID(value: String)
    {
        set(value, forKey: UserDefaultsKeys.emailID.rawValue)
    }

    func getEmailID() -> String
    {
        guard string(forKey: UserDefaultsKeys.emailID.rawValue) != nil else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.emailID.rawValue)!

    }

    func setMobileNo(value: String)
    {
        set(value, forKey: UserDefaultsKeys.mobileNo.rawValue)
    }

    func getMobileNo() -> String
    {
        guard string(forKey: UserDefaultsKeys.mobileNo.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mobileNo.rawValue)!
    }

    func setTermsURL(value: String)
    {
        set(value, forKey: UserDefaultsKeys.termsURL.rawValue)
    }

    func getTermsURL() -> String
    {
        guard string(forKey: UserDefaultsKeys.termsURL.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.termsURL.rawValue)!
    }

    func setMapKey(value: String)
    {
        set(value, forKey: UserDefaultsKeys.mapKey.rawValue)
    }

    func getMapKey() -> String
    {
        guard string(forKey: UserDefaultsKeys.mapKey.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mapKey.rawValue)!
    }

    func setCurrentaddress(value: String)
    {
        set(value, forKey: UserDefaultsKeys.currentAddress.rawValue)
    }

    func getCurrentAddress() -> String {

        return string(forKey: UserDefaultsKeys.currentAddress.rawValue)!
    }

    func getCartDetails() -> [CartDishDetails]?
    {
        let cartData = UserDefaults.standard.data(forKey: "cartObjectData")
         if cartData != nil{
            let cartArray = try! JSONDecoder().decode([CartDishDetails].self, from: cartData!)
            return cartArray
        }
         else{
            return nil
        }
    }

    func setCartDetails(value: [CartDishDetails])
    {
        let cartFinalData = try! JSONEncoder().encode(value)
        UserDefaults.standard.set(cartFinalData, forKey: "cartObjectData")
    }

    func getRecentSearchList() -> [RecentSearchList]?
    {
        let placeData = UserDefaults.standard.data(forKey: "recentSearchList")
        if placeData != nil{
            let placeArray = try! JSONDecoder().decode([RecentSearchList].self, from: placeData!)
            return placeArray
        }
        else{
            return nil
        }
    }
    */
}


enum UserDefaultsKeys : String
{
    case isLoggedIn
    case firstName
    case lastName
    case mobileNo
    case accessToken
    case userImage
    case rating
    case emailId
    case language
    case name
    case userID
    case latitude
    case longitude
    case countryCode
    case profilePic
    case voipToken
    case branch
    case userAddress
    case deviceToken
}

struct UserDefaultsKey {
    static let isUserLogin = "isUserLogin"
    static let userID = "UserId"
    static let guestId = "gid"
    static let name = "name"
    static let email = "email"
    static let password = "mypassword"
    static let phone = "phone"
    static let gender = "gender"
    static let birthday = "birthday"
    static let imageUrl = "image"
    static let accessToken = "accessToken"
    static let deviceToken = "deviceToken"
    static let userProfileImage = "userProfileImage"
    
    static let isCitySelected = "isCitySelected"
    static let isIntroPageDone = "isIntroPageDone"
    static let userSelectedCity = "userSelectedCity"
    static let userSelectedCityId = "userSelectedCityId"
    
    static let isCountrySelected = "isCountrySelected"
    static let userSelectedCountry = "userSelectedCountry"
    static let userSelectedCountryId = "userSelectedCountryId"
    static let userSelectedCountryCurrency = "userSelectedCountryCurrency"

    
    static let currentController = "currentController"
    static let menuPageUrl = "menuPageUrl"
    static let menuPageTitle = "menuPageTitle"
    
    static let notificationBadgeCount = "notificationBadgeCount"
    
    static let tax_vat = "tax_vat"
    static let wallet_amount = "wallet_amount"
    static let coupon_wallet_amount = "coupon_wallet_amount"
    static let coupon_amount = "coupon_amount"
    static let cart_id = "cart_id"
    static let order_id = "order_id"
    static let applied_wallet_amount = "applied_wallet_amount"
    static let finalOrderAmount = "finalOrderAmount"
    static let coupon_code = "coupon_code"
    static let coupon_id = "coupon_id"
    static let coupon_detail = "coupon_detail"
    static let shipping_id = "shipping_id"
    static let shipping_charge = "shipping_charge"
    
    static let paymentCheckoutId = "checkoutId"
    
}
