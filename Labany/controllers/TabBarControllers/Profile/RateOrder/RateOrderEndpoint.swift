//
//  RateOrderEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation
class RateOrderWebServices {
    class func getQuestionsApi (completionHundler: @escaping (RateOrderresponse?,String?) -> Void){

        NetworkRequest.Request(url: APIs.Instance.questionsUrl(), method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
            let parsedResult = try JSONDecoder().decode(RateOrderresponse?.self,from:(response?.data)!)
                        
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
    
class func saveRateOrderApi (parameters:[String : Any],completionHundler: @escaping (Model?,String?) -> Void){
        
        NetworkRequest.Request(url: APIs.Instance.saveFeedbackUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
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
