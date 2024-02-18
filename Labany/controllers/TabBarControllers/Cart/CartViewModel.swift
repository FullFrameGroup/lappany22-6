//
//  CartViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/18/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController
import Moya

protocol CartOrderViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func fetchCartItemsSuccessfully()
    func fetchVisaSuccessfully()
    func hideSelectDateView(_ hide:Bool)
    func orderAddedSuccessfully(msg:String)
    func orderAddFail(message:String)
    func cashingSuccessfully(msg:String)
    func deleteItemSuccessfully(msg:String)
    func getCartTimes(times:[TimesOpen]?)
    func catchError()
}



class CartViewModel {
        weak var delegate: CartOrderViewModelDelegate?
    let appProvider = MoyaProvider<AppProvider>()

        init(delegate:CartOrderViewModelDelegate?) {
            self.delegate = delegate
        }
    
    
    var cartData:CartModel?
    var visaArr:[VisaTypeModel]?
    var cartItemsArr:[CartItemsModel]?
    var timesArr:[TimesOpen]?
  
    func getCartData(user_id:Int) {
            self.delegate?.showLoading()
            CartWebServices.getCartApi(user_id:user_id ){ [weak self] (data, error) in
                guard let self else {return}
       self.delegate?.killLoading()
    
       if error == nil && data == nil {
           print("Connection failed")
           self.delegate?.connectionFailed()
    
       } else if (error != nil)  {
    
          self.delegate?.showErrorAlert(error: error ?? "")
    
       } else if (data?.success == false){
           
         self.delegate?.showErrorAlert(error: data?.msg ?? "")
    
       }
           else if (data?.success == true){
               //phoneRegister succ
               print("Cart Data:",data?.data)
               self.cartData = data?.data
               self.visaArr = data?.data?.visa_types
               self.cartItemsArr = data?.data?.cart_items
               self.delegate?.fetchVisaSuccessfully()
               self.delegate?.fetchCartItemsSuccessfully()
               self.delegate?.hideSelectDateView(data?.data?.date_setting?.open == "off" ? true : false)
           }
       }
    
    }
    
    
    func addOderApi(parameters: [String : Any]){
        self.delegate?.showLoading()

        appProvider.request(.addOrder(param: parameters)) { result in
            self.delegate?.killLoading()
                         switch result {
                         case let .success(moyaResponse):
                             print("Add Order Response:\(String(data:moyaResponse.data,encoding: .utf8))")
                                let jobsResponse = try? moyaResponse.map(MakeOrderModel.self)
                          //  print(jobsResponse)
                            
                           if jobsResponse?.code == 200
                           {
                            self.delegate?.orderAddedSuccessfully(msg:jobsResponse?.msg ?? "")

                           }
                          else
                           {
                              let message = jobsResponse?.msg
                              
                            self.delegate?.orderAddFail(message: message ?? "")
                              
                              
                           }
                            
                         case let .failure(error):
                             break
                         }
                     }
   }
    
    var coupon:CouponData?
    var couponDetail:CouponDetails?
    
    func callCheckCouponApi(parameters: [String : Any]) {
       CheckCopunWebService.callCheckOrderCouponApi(parameters: parameters){ [self] (data, error) in
       self.delegate?.killLoading()
       
       if error == nil && data == nil {
           print("Connection failed")
        self.delegate?.connectionFailed()

       } else if (error != nil) {
           
          self.delegate?.showErrorAlert(error: error ?? "")
           
       } else if (data?.success == false){
       self.delegate?.showErrorAlert(error: data?.msg ?? "")
           
       }
           else if (data?.success == true){
               //phoneRegister succ
            
            coupon = data?.data
            couponDetail = data?.data?.Coupon
               self.delegate?.cashingSuccessfully(msg: data?.msg ?? "")
           }
       }

   }
    
    func deleteItemApi(user_id:Int,cartId:Int,cartItemId:Int) {
        
        CartWebServices.deleteCartItemApi(user_id:user_id,cartId:cartId,cartItemId:cartItemId){ [self] (data, error) in
   self.delegate?.killLoading()
   
   if error == nil && data == nil {
       print("Connection failed")
       self.delegate?.connectionFailed()

   } else if (error != nil)  {
       
      self.delegate?.showErrorAlert(error: error ?? "")
       
   } else if (data?.success == false){
   self.delegate?.showErrorAlert(error: data?.msg ?? "")
       
   }
       else if (data?.success == true){
        self.delegate?.deleteItemSuccessfully(msg:data?.msg ?? "")
        
       }

}
}
        func getTimeAvailable(dateslected:String){
            self.delegate?.showLoading()
    
            CartWebServices.getAvilableTimeApi(dateslected:dateslected ){ [self] (data, error) in
                self.delegate?.killLoading()
    
                if error == nil && data == nil {
                    print("Connection failed")
                } else if (error != nil)  {
    
                } else if (data?.success == false){
    
                }
                else if (data?.success == true){
                    timesArr = data?.data?.time_slot
                    self.delegate?.getCartTimes(times: timesArr ?? [])
                }
            }
    
        }
    
    
    
    
    
    func catchErrorsApi(code:Int,platformtype:String,message:String){
                self.delegate?.showLoading()
        CartWebServices.ExeptionApi(code:code,message:message, platformtype:platformtype ){ [self] (data, error) in
                    self.delegate?.killLoading()
                    if error == nil && data == nil {
                        print("Connection failed")
        //                self.delegate?.connectionFailed()
                    } else if (error != nil)  {
        
                        self.delegate?.showErrorAlert(error: error ?? "")
        
                    } else if (data?.success == false){
                        self.delegate?.showErrorAlert(error: data?.msg ?? "")
        
                    }
                    else if (data?.success == true){
                    }
                }
        
            }
    
    
    func addPaymentApi(parameters: [String : Any]){
        appProvider.request(.addPayment(param: parameters)) { result in
            self.delegate?.killLoading()
                         switch result {
                         case let .success(moyaResponse):
                             print("Add Payment Response:\(String(data:moyaResponse.data,encoding: .utf8))")
                           let jobsResponse = try? moyaResponse.map(MakeOrderModel.self)
                          //  print(jobsResponse)
                            
                           if jobsResponse?.code == 200
                           {
                            self.delegate?.orderAddedSuccessfully(msg:jobsResponse?.msg ?? "")

                           }
                          else
                           {
                              let message = jobsResponse?.msg
                              
                            self.delegate?.orderAddFail(message: message ?? "")
                              
                              
                           }
                            
                         case let .failure(error):
                             break
                         }
                     }
   }
}
