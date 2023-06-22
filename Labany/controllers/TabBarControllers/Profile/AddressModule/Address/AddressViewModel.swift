//
//  AddressViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
import PKHUD
import Alamofire
////import SwiftyJSON
import MIAlertController

protocol AddressViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserAddressSuccessfully(address:[shippingArrressList])
    func deleteAddressSuccessfully()
}

class AddressViewModel {
    weak var delegate: AddressViewModelDelegate?
    init(delegate:AddressViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var addressArr:[shippingArrressList]?
    
    func getUserAddressApi(user_id:Int) {
        self.delegate?.showLoading()
        AddressWebServices.getAddressApi(user_id:user_id){ [self] (data, error) in
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
        addressArr = data?.data?.shipping
           
           self.addressArr = data?.data?.shipping
    self.delegate?.GetUserAddressSuccessfully(address:addressArr ?? [])
        
       }

}
}
    
    func deleteAddressApi(user_id:Int,shipping_id:Int) {
        
        AddressWebServices.deleteddressApi(user_id:user_id,shipping_id: shipping_id){ [self] (data, error) in
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
           // Address deleted Successfully
        
    self.delegate?.deleteAddressSuccessfully()
           
        
       }

}
}
    
}
