//
//  MyOrdersListEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import Foundation
class MyOrdersListWebServices {
    
    
    class func getMyOrdersApi(user_id:Int, completionHundler: @escaping (MyOrdersResponse?,String?) -> Void){
        let url = "\(APIs.Instance.getMyOrdersListUrl())?user_id=\(user_id)"
        NetworkRequest.Request(url: url, method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(MyOrdersResponse?.self,from:(response?.data)!)
                        
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
    //MARK:- DeleteOrderByOrderID
    
class func deleteOrderApi (user_id:Int,order_id:Int,completionHundler: @escaping (Model?,String?) -> Void){
       
    let url = "\(APIs.Instance.deleteOrdertUrl())?user_id:\(user_id)&order_id:\(order_id)"
        
        NetworkRequest.Request( url: url, method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
            let parsedResult = try JSONDecoder().decode(Model?.self,from:(response?.data)!)
                        
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
