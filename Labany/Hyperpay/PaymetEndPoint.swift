//
//  PaymetEndPoint.swift
//  Labany
//
//  Created by Eman Gaber on 25/05/2022.
//

import Foundation
import Alamofire
//import SwiftyJSON

class PaymetEndPoint {
 
    class func createCheckOutApi(amount:Int,method:String,merchantTransactionId:Int,paymentMethod:String ,completionHundler: @escaping (String?,String?) -> Void){
        let parameters = ["amount":amount,"method":method,"merchantTransactionId":merchantTransactionId, "merchantInvoiceId":merchantTransactionId,"payment_method":paymentMethod] as [String : Any]

        NetworkRequest.Request( url: APIs.Instance.createCheckOutApi(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(CheckoutIDModel?.self,from:(response?.data)!)
                        print(parsedResult)
                        if parsedResult?.success == true
                        {
                            completionHundler(parsedResult?.checkoutID,nil)
                            
                        }else
                        {
                            completionHundler(nil,"error")
                        }
                    }catch{
                        print("CheckoutIDModel errorrrr catcchhchchchc")
                        print (error)
                        completionHundler(nil, error.localizedDescription)
                        
                    }
                }else{
                    print("error area busy in method")
                    completionHundler(nil, error)
                }
            }
        }
    }
    
    
    
    class func checkPaymentStatus(merchantTransactionId:String,merchantInvoiceId:String, resourcePath:String,method:String, completionHundler: @escaping (String?,String?) -> Void){
        
           let parameters = ["merchantTransactionId":merchantTransactionId,
                             "merchantInvoiceId":merchantInvoiceId,
                             "resourcePath":resourcePath
                             ,"method":method] as [String : Any]

           NetworkRequest.Request( url: APIs.Instance.createCheckOutApi(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
               response , error in
               
               if response == nil && error == nil{
                   completionHundler(nil,nil)
               }else{
                   if error == nil{
                       do {
                           let parsedResult = try JSONDecoder().decode(CheckoutIDModel?.self,from:(response?.data)!)
                           
                           //print(parsedResult)
                           if parsedResult?.success == true
                           {
                               completionHundler(parsedResult?.msg,nil)
                               
                           }else
                           {
                               completionHundler(nil,parsedResult?.msg)
                           }
                       }catch{
                           print("CheckoutIDModel errorrrr catcchhchchchc")
                           print (error)
                           completionHundler(nil, error.localizedDescription)
                           
                       }
                   }else{
                       print("error area busy in method")
                       completionHundler(nil, error)
                   }
               }
           }
       }
}
