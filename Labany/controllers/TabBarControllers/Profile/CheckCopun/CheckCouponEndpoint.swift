//
//  CheckCouponEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation

class CheckCopunWebService{

    class func callCheckWalletCouponApi(parameters: [String : Any], completionHundler: @escaping (Model?,String?) -> Void){
    NetworkRequest.Request( url: APIs.Instance.checkCouponWalletUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
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
                    print("errorrrr catcchhchchchc")
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
    
    
    class func callCheckOrderCouponApi(parameters: [String : Any], completionHundler: @escaping (CoUponCartModel?,String?) -> Void){
    NetworkRequest.Request( url: APIs.Instance.checkOrderCouponUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
        response , error in
        
        if response == nil && error == nil{
            completionHundler(nil,nil)
        }else{
            if error == nil{
                do {
                    let parsedResult = try JSONDecoder().decode(CoUponCartModel?.self,from:(response?.data)!)
                    
                    if parsedResult?.success == false
                    {
                        completionHundler(parsedResult,parsedResult?.msg)
                        
                    }else
                    {
                        completionHundler(parsedResult,nil)
                    }
                }catch{
                    print("errorrrr catcchhchchchc")
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
