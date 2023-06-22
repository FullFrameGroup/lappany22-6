//
//  HomeEndPoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/14/21.
//

import Foundation
import Alamofire
//import SwiftyJSON
import PKHUD
class HomeWebServices {
    
    class func getHomeCategoriesApi(cityId:Int, completionHundler: @escaping (HomeResponse?,String?) -> Void){
    let parameters = ["city_id":cityId] as [String : Any]
       
        NetworkRequest.Request( url: APIs.Instance.homeCategoriesUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(HomeResponse?.self,from:(response?.data)!)
                        
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
