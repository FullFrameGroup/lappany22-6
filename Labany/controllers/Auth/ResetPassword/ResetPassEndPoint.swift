//
// ResetPassEndPoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/14/21.
//

import Foundation
import Alamofire
//import SwiftyJSON

class ResetPassWebServices {
    
class func callResetPassApi(parameters: [String : Any], completionHundler: @escaping (CheckCodeResponse?,String?) -> Void){
        NetworkRequest.Request( url: APIs.Instance.resetPasswordUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(CheckCodeResponse?.self,from:(response?.data)!)
                        
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