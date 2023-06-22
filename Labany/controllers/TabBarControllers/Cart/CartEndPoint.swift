//
//  CartEndPoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import Alamofire
//import SwiftyJSON

class CartWebServices {
 
    class func getCartApi(user_id:Int, completionHundler: @escaping (CartResponse?,String?) -> Void){
    let parameters = ["user_id":user_id] as [String : Any]

        NetworkRequest.Request( url: APIs.Instance.getCartUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(CartResponse?.self,from:(response?.data)!)
                        
                        if parsedResult?.success == false
                        {
                            
                            completionHundler(parsedResult,parsedResult?.msg)
                            
                        }else
                        {
        
                            General.sharedInstance.cartID = parsedResult?.data?.cart_id ?? 0

                            completionHundler(parsedResult,nil)
                        }
                    }catch{
                        print("CartResponse errorrrr catcchhchchchc")
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
    
    class func getAvilableTimeApi(dateslected:String ,completionHundler: @escaping (mrketTimes?,String?) -> Void){
        
        let url = "\(APIs.Instance.avaliableTimeUrl())?date=\(dateslected)"
        print(url)
        NetworkRequest.Request( url:url, method: .get, parameters: nil, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(mrketTimes?.self,from:(response?.data)!)
                        
                        if parsedResult?.success == false
                        {
                            completionHundler(parsedResult,parsedResult?.msg)
                            
                        }else
                        {
        
                            completionHundler(parsedResult,nil)
                        }
                    }catch{
                        print("TimeAvailableResponse errorrrr catcchhchchchc")
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
    
    
    func getTime(dateslected: String, completion: @escaping(_ dataError: Bool, _ timeData: timeData?)-> Void){
        
        let url = "\(APIs.Instance.avaliableTimeUrl())?date=\(dateslected)"
        print(url)

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: APIs.Instance.commonHeaders()).responseJSON { (response) in
            do{
                switch response.result{
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                case .success(let value):
                    print(value)
                    let homeData = try JSONDecoder().decode(mrketTimes.self, from: response.data!)
                    completion(false, homeData.data)
                }
            }catch{
                print("getTime errorrrr catcchhchchchc")
                completion(true,nil)
            }
        }
    }
    
    
    class func deleteCartItemApi (user_id:Int,cartId:Int,cartItemId:Int,completionHundler: @escaping (Model?,String?) -> Void){
       
        let parameters = ["user_id":user_id,"cartId":cartId,"cartItemId":cartItemId] as [String : Any]
        
        NetworkRequest.Request( url: APIs.Instance.deleteCartItemUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
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
                        print("DeleteCart errorrrr catcchhchchchc")
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
    
    
    
    
    
    
    class func ExeptionApi (code:Int,message:String,platformtype:String,completionHundler: @escaping (Model?,String?) -> Void){
     
        NetworkRequest.Request( url: APIs.Instance.exptionUrl(), method: .post, parameters: nil, headers: APIs.Instance.commonHeaders()){
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
                        print("Exeption errorrrr catcchhchchchc")
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
