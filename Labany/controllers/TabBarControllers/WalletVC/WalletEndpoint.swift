//
//  WalletEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation

class WalletWebServices {
    class func getWalletsApi (user_id:Int,completionHundler: @escaping (WalletResponse?,String?) -> Void){
       
//        let parameters = ["user_id":user_id] as [String : Any]
        let url = "\(APIs.Instance.walletsUrl())?user_id=\(user_id)"
        NetworkRequest.Request(url: url, method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
            let parsedResult = try JSONDecoder().decode(WalletResponse?.self,from:(response?.data)!)
                        
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
