//
//  ProductDetailsEndpoint.swift
//  Labany
//
//  Created by Eman Gaber on 7/25/21.
//

import Foundation
import Moya

class PdoductDetailsWebServices {
    
    let appProvider = MoyaProvider<AppProvider>()

    class func ProductDetailsApi(cityId:Int,productId:Int, completionHundler: @escaping (ProductDetailsResponse?,String?) -> Void){
        let parameters = ["cityId":cityId,"productId":productId] as [String : Any]
        NetworkRequest.Request( url: APIs.Instance.productDetailstUrl(), method: .post, parameters: parameters, headers: APIs.Instance.commonHeaders()){
            response , error in
            
            if response == nil && error == nil{
                completionHundler(nil,nil)
            }else{
                if error == nil{
                    do {
                        let parsedResult = try JSONDecoder().decode(ProductDetailsResponse?.self,from:(response?.data)!)
                        
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

    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    
    
     func addToCartApi(user_id:Int,parameters: [String : Any], completionHundler: @escaping (MakeOrderModel?,String?) -> Void){

        appProvider.request(.addToCart(userId: user_id, param: parameters)) { result in

                          switch result {
                          case let .success(moyaResponse):
                            let jobsResponse = try? moyaResponse.map(MakeOrderModel.self)
                            if jobsResponse?.success == false
                            {
                                completionHundler(jobsResponse,jobsResponse?.msg)
                            }
                           else
                            {
                            completionHundler(jobsResponse,nil)

                            }

                          case let .failure(_):
                              break
                          }
                      }
    }
    
}

    struct GenericApiMessageModel: Decodable {
        let status: Int?
        let message: String?
    }
