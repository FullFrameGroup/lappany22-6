//
//  ComplaintListEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import Foundation
class ComplaintsListWebServices {

//GEt ALL Complaints ----------

    class func getComplaintsListApi (user_id:Int,completionHundler: @escaping (ComplaintsListResponse?,String?) -> Void){
       
//        let parameters = ["user_id":user_id] as [String : Any]
        let url = "\(APIs.Instance.getcComplaintListUrl())?user_id=\(user_id)"
        NetworkRequest.Request(url: url, method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
            let parsedResult = try JSONDecoder().decode(ComplaintsListResponse?.self,from:(response?.data)!)
                        
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
