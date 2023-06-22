//
//  TermsEndPoint.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation
class TermsWebServices {
    class func getTermsApi (completionHundler: @escaping (TermsModel?,String?) -> Void){
       
        NetworkRequest.Request( url: APIs.Instance.notificationsUrl(), method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
            let parsedResult = try JSONDecoder().decode(TermsModel?.self,from:(response?.data)!)
                        
            if ((parsedResult?.success) != nil) == false
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
