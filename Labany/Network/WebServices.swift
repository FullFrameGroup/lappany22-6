//
//  WebServices.swift
//  Labany
//
//  Created by iMac on 05/07/2021.
//

import Foundation
import UIKit
import Alamofire
//import SwiftyJSON

class WebServices {
    
    //MARK: ----- Authentication -----
    
//    class func registerApi(parameters: [String : Any], completionHundler: @escaping (RegistrationResponse?,String?) -> Void){
//        NetworkRequest.Request( url: APIs.Instance.registerUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
//            response , error in
//
//            if response == nil && error == nil{
//                completionHundler(nil,nil)
//            }else{
//                if error == nil{
//                    do {
//                        let parsedResult = try JSONDecoder().decode(RegistrationResponse?.self,from:(response?.data)!)
//
//                        if parsedResult?.success == false
//                        {
//                            completionHundler(parsedResult,parsedResult?.msg)
//
//                        }else
//                        {
//                            completionHundler(parsedResult,nil)
//                        }
//                    }catch{
//                        print("errorrrr catcchhchchchc")
//                        print (error)
//                        completionHundler(nil, error.localizedDescription)
//
//                    }
//                }else{
//                    print("error area busy in method")
//                    completionHundler(nil, error)
//                }
//            }
//        }
//    }
    
    
    
    
    
    class func callVerifyCodeApi(parameters: [String : Any], completionHundler: @escaping (VerifyCodeResponse?,String?) -> Void){
        NetworkRequest.Request( url: APIs.Instance.verifyCodeUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(VerifyCodeResponse?.self,from:(response?.data)!)
                        
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

    
    class func callCheckCodeApi(parameters: [String : Any], completionHundler: @escaping (SigneInModel?,String?) -> Void){
        NetworkRequest.Request( url: APIs.Instance.checkCodeUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(SigneInModel?.self,from:(response?.data)!)
                        
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
