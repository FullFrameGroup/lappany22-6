//
//  APIS.swift
//  Labany
//
//  Created by iMac on 05/07/2021.
//

import Foundation
import Alamofire

class APIs {
    static let Instance = APIs()
    private init() {}
    
    public func commonHeaders () -> HTTPHeaders
    {
        let headers : HTTPHeaders = ["Accept":"application/json",
                                     "x_api_key":"WYLUnBhBpGltg?##$%%^Y##$GZWcXfIW","Content-Type":"application/json","Content-Type": "application/x-www-form-urlencoded"]
        return headers
        
    }
    
    public func commonHeadersOther () -> HTTPHeaders
    {
        let headers : HTTPHeaders = ["Accept":"application/json",
                                     "x_api_key":"WYLUnBhBpGltg?##$%%^Y##$GZWcXfIW","Content-Type":"application/json","Content-Type": "application/json"]
        return headers
        
    }
    
    //MARRK:-online
    private let baseUrl = "https://nokhbaapp.com/new/api_v4/" //"https://labbany.update.tharrwa.com/api_v4/"
    

    //MARRK:- Authentications ============
    public func registerUrl() -> String {
        return baseUrl + "signup_new.php"
    }
    public func phoneRegisterUrl() -> String {
        return baseUrl + "phone_registration.php"
    }
    public func verifyCodeUrl() -> String {
        return baseUrl + "resend_otp.php"
    }
    public func checkCodeUrl() -> String {
        return baseUrl + "otpVerify.php"
    }
    public func loginUrl() -> String {
        return baseUrl + "login.php"
    }
    public func forrgetPassUrl() -> String {
        return baseUrl + "forget_password.php"
    }
  
    public func homeCategoriesUrl() -> String {
        return baseUrl + "productList.php"
    }
    
  
    public func userDataUrl() -> String {
        return baseUrl + "profile.php"
    }
    
    public func resetPasswordUrl() -> String {
        return baseUrl + "reset_password.php"
    }
    
    public func editUserDataUrl() -> String {
        return baseUrl + "update_profile.php"
    }
    
    public func changePasswordUrl() -> String {
        return baseUrl + "change_password.php"
    }
    
    
    public func cityUrl() -> String {
        return baseUrl + "city_list.php"
    }
    
    public func termsUrl() -> String {
        return baseUrl + "terms.php"
    }
    
    public func setCityUrl() -> String {
        return baseUrl + "set_city.php"
    }
    
    public func logoutUrl() -> String {
        return baseUrl + "logout.php"
    }
    
    public func deletAccountUrl() -> String {
        return baseUrl + "delete_user.php"
    }
    
    
    public func socialLoginUrl() -> String {
        return baseUrl + "social_login.php"
    }
   
    public func productDetailstUrl() -> String {
        return baseUrl + "product_detials.php"
    }
    
    // MARRK:-Notifications ============

    public func notificationsUrl() -> String {
        return baseUrl + "get_notification.php"
    }
    //MARRK:- Wallet ============
    public func walletsUrl() -> String {
        return baseUrl + "wallet_detail.php"
    }
    
   //MARRK:- Address ===================
    public func getAddesslistUrl() -> String {
        return baseUrl + "get_shipping_list.php"
    }
    public func deleteAddesslistUrl() -> String {
        return baseUrl + "delete_shipping_address.php"
    }
    public func addAddessUrl() -> String {
        return baseUrl + "add_shipping_address.php"
    }
    public func updateAddessUrl() -> String {
        return baseUrl + "update_shipping_address.php"
    }
    
    // MARRK:-Complaints--------------
    public func uploadComplaintUrl() -> String {
        return baseUrl + "upload_complaint.php"
    }
    public func getcComplaintTypeUrl() -> String {
        return baseUrl + "get_complaint_type.php"
    }
    
    public func getcComplaintListUrl() -> String {
        return baseUrl + "compliants.php"
    }
    
    //MARRK:- ORDERS API -------------
    public func getMyOrdersListUrl() -> String {
        return baseUrl + "my_order.php"
    }
    
    public func getMyOrderDetailsUrl() -> String {
        return baseUrl + "order_detail.php"
    }
    public func deleteOrdertUrl() -> String {
        return baseUrl + "cancel_order.php"
    }
    
    //MARK:- VISA
    public func getAllVisaUrl() -> String {
        return baseUrl + "all_visa.php"
    }

    public func addVisaUrl() -> String {
        return baseUrl + "add_visa.php"
    }

    public func deletVisaUrl() -> String {
        return baseUrl + "delete_visa.php"
    }
    
    
    public func getCartUrl() -> String {
        return baseUrl + "cart_detail.php"
    }
    
    public func addCartUrl(user_id:Int) -> String {
        return baseUrl + "add_cart.php/\(user_id)"
    }

    public func deleteCartItemUrl() -> String {
        return baseUrl + "cart_item_delete.php"
    }
    
    
    //MARK:- COUPON
    public func checkCouponWalletUrl() -> String {
        return baseUrl + "check_coupon_wallet.php"
    }
    public func checkOrderCouponUrl() -> String {
        return baseUrl + "check_coupon.php"
    }
    
    public func questionsUrl() -> String {
        return baseUrl + "feedback_questions.php"
    }
    public func saveFeedbackUrl() -> String {
        return baseUrl + "save_feedback_questions.php"
    }
    
    public func avaliableTimeUrl() -> String {
        return baseUrl + "time_slot.php"
    }
    
    public func exptionUrl() -> String {
        return baseUrl + "exception.php"
    }
    
    
   public func createCheckOutApi() -> String {
       return baseUrl + "paymenthypnew.php"
   }
    
    
}
