//
//  MakeComplaintEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/29/21.
//

import Foundation

class ComplaintsWebServices {
 //UPLOAd Complainnts -----------
class func uploadComplaintsApi (parameters:[String : Any],completionHundler: @escaping (Model?,String?) -> Void){
 
    NetworkRequest.Request( url: APIs.Instance.uploadComplaintUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
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
    
   // GEt Complaints Type ----------
    
    class func getComplaintsTypeApi(completionHundler: @escaping (ComplaintsResponse?,String?) -> Void){
        
        NetworkRequest.Request( url: APIs.Instance.getcComplaintTypeUrl(), method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(ComplaintsResponse?.self,from:(response?.data)!)
                        
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
