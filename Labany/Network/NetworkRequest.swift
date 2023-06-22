//
//  NetworkRequest.swift
//  CaptinApp
//
//  Created by Eman Gaber on 26/01/2021.
//  Copyright © 2021 Drovox Company. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

class NetworkRequest{
    
    class func Request(url : String, method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders?, encoding: ParameterEncoding = URLEncoding.default, completionHundler: @escaping (DataResponse<Any, AFError>? ,String?)->Void) {
        print (url)
        print (parameters)
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response:DataResponse) in
           
            switch(response.result) {
            case .success(let value):
                print(value)
                //print(response.response)
                let temp = response.response?.statusCode ?? 400
                print(temp)
                if temp == 401
                {
                    // token expire
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callGenerateToken"), object: nil)
                    
                    completionHundler(nil,nil)
                    
                }else
                {
                    completionHundler(response,nil)

                }
                
                print(response.data!)
            case .failure(_):
                let lockString = NSLocalizedString("Something went wrong please try again later", comment: "حدث خطأ برجاء اعادة المحاولة")
                print(lockString)
                print(response.error?.localizedDescription)
                completionHundler(nil,nil)
                break
            }
        }
    }
    
  
    class func RequestWithBody(request : URLRequest, completionHundler: @escaping (DataResponse<Any, AFError>? ,String?)->Void) {
        
        AF.request(request).responseJSON { (response:DataResponse) in
           
            switch(response.result) {
            case .success(let value):
                print(value)
                print(response.data!)
                completionHundler(response,nil)
            
            case .failure(_):
                let lockString = NSLocalizedString("Something went wrong please try again later", comment: "حدث خطأ برجاء اعادة المحاولة")
                print(lockString)
                print(response.error?.localizedDescription)
                completionHundler(nil,nil)
                break
            }
        }
    }
 
    //MARK: - Regesteration
    
    
    class func callRegister(Url: String, userImage: UIImage? ,params: [String : Any], compilition : @escaping (_ result : Bool ,_ message:String,_ userId:Int)->Void)
    {
        
        print(Url)
        
        let headers : HTTPHeaders = ["Accept":"application/json",
                                     "x_api_key":"WYLUnBhBpGltg?##$%%^Y##$GZWcXfIW","Content-Type":"application/json","Content-Type": "application/x-www-form-urlencoded"]
        
        
        
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for p in params {
                multipartFormData.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            
            
            if userImage != nil {
                
                let data = General.compressImage(image: userImage!)
                
                multipartFormData.append(data, withName: "image", fileName: "img.png", mimeType: "image/png")
            }
            
            
            
        }, to: encodedURL!,usingThreshold: UInt64.init(),method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            
        }
        ).response { (response) in
            switch response.result {
            case .success(let resut):
                
                let json = JSON(resut!)
                print(json)
                
                if json["success"] == false {
                    compilition(false, "\(json["msg"])",0)

                }else
                {
                    //"register success"

                    let userId =  General.CheckNull(json["data"]["id"]) ?? ""
                   
                    compilition(true, "regesteration_success".localized,Int(userId)!)
                }
                
            case .failure(let err):
                print("upload err: \(err)")
                compilition(false, "error".localized,0)
            }
        }
    }
    
    class func callUpdateProfile(Url: String, userImage: UIImage? ,params: [String : Any], compilition : @escaping (_ result : Bool ,_ message:String,_ userName:String, _ email:String,_ image:String)->Void)
    {
        
        print(Url)
        
        let headers : HTTPHeaders = ["Accept":"application/json",
                                     "x_api_key":"WYLUnBhBpGltg?##$%%^Y##$GZWcXfIW","Content-Type":"application/json","Content-Type": "application/x-www-form-urlencoded"]
        
        
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for p in params {
                multipartFormData.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            
            
            if userImage != nil {
                
                let data = General.compressImage(image: userImage!)
                
                multipartFormData.append(data, withName: "image", fileName: "img.png", mimeType: "image/png")
            }
            
            
            
        }, to: encodedURL!,usingThreshold: UInt64.init(),method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            
        }
        ).response { (response) in
            switch response.result {
            case .success(let resut):
                
                let json = JSON(resut!)
                print(json)
                
                if json["success"] == false {
                    compilition(false, "\(json["msg"])","","","")

                }else
                {
                    //"update success"
//
                    let username =  General.CheckNull(json["data"]["username"]) ?? ""
                    let email =  General.CheckNull(json["data"]["email"]) ?? ""
                    let image =  General.CheckNull(json["data"]["image"]) ?? ""

                    compilition(true, "regesteration_success".localized,username,email,image)
                    
                }
                
                
            case .failure(let err):
                print("upload err: \(err)")
                compilition(false, "error".localized,"","","")
            }
        }
    }
  
    }
