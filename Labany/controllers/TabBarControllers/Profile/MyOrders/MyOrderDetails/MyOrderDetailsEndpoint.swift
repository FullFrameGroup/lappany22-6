//
//  MyOrderDetailsEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 8/2/21.
//

import Foundation

class OrderDetailsWebServices {
    
    class func orderDetailsApi(user_id:Int,order_id:Int ,completionHundler: @escaping (OrderDetailsResponse?,String?) -> Void){
        
        let url = "\(APIs.Instance.getMyOrderDetailsUrl())?user_id=\(user_id)&order_id=\(order_id)"
        NetworkRequest.Request( url:url, method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(OrderDetailsResponse?.self,from:(response?.data)!)
                        
                        if parsedResult?.success == false
                        {
                            completionHundler(parsedResult,parsedResult?.msg)
                            
                        }else
                        {
        
                            completionHundler(parsedResult,nil)
                        }
                    }catch{
                        print("HomeResponse errorrrr catcchhchchchc")
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
