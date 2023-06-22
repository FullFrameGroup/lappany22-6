//
//  PaymentViewmodel.swift
//  Labany
//
//  Created by Mac on 11/08/2021.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol PaymentViewmodelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetPaymentListSuccessfully(visa:[VisaModel]?)
    func deleteVisaSuccessfully(msg:String)
}

class PaymentViewmodel {
    weak var delegate: PaymentViewmodelDelegate?
    init(delegate:PaymentViewmodelDelegate?) {
        self.delegate = delegate
    }
    
    
    var visaArr:[VisaModel]?
    var visaObjc:VisaResponse?
    
    func getUserVisaApi(userid:Int,visaTypeid:Int) {
        self.delegate?.showLoading()
        VisaWebServices.getVisaApi(user_id:userid,visa_type_id:visaTypeid){ [self] (data, error) in
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
                visaArr = data?.data
    self.delegate?.GetPaymentListSuccessfully(visa:visaArr ?? [] )
                
            }
            
        }
    }

    
    
    
    
    func deleteVisaApi(user_id:Int,visa_id:Int) {
        
        VisaWebServices.deleteVisaApi(user_id:user_id,visa_id: visa_id){ [self] (data, error) in
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
        
    self.delegate?.deleteVisaSuccessfully(msg: data?.msg ?? "")
        
       }

}
}

}
