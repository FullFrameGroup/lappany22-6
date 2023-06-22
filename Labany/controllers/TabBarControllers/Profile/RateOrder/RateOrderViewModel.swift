//
//  RateOrderViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation
import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController
import Moya

protocol RateOrderViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserquestionsSuccessfully()
    func saveRateSuccessfully(msg:String)
    func rateFailed(msg:String)
}

class RateOrderViewModel {
    weak var delegate: RateOrderViewModelDelegate?
    init(delegate:RateOrderViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var qusArr:[questions]?
    
    let appProvider = MoyaProvider<AppProvider>()

    func getQuestionnsApi(user_id:Int) {
        self.delegate?.showLoading()
        RateOrderWebServices.getQuestionsApi(){ [self] (data, error) in
            self.delegate?.killLoading()
            
            if error == nil && data == nil {
                print("Connection failed")
                self.delegate?.connectionFailed()
                
            } else if (error != nil)  {
                
                self.delegate?.showErrorAlert(error: error ?? "")
                
            } else if (data?.success == false){
                self.delegate?.showErrorAlert(error: data?.msg ?? "")
                
            }
            else if (data?.success == true){
                qusArr = data?.data?.feedback_questions
                
                self.delegate?.GetUserquestionsSuccessfully()
            }
            
        }
    }
    
    func saveRateApi(parameters: [String : Any]) {
    self.delegate?.showLoading()

        appProvider.request(.addRate(param: parameters)) { result in
        self.delegate?.killLoading()
                     switch result {
                     case let .success(moyaResponse):
                       let jobsResponse = try? moyaResponse.map(MakeOrderModel.self)
                        print(jobsResponse!)
                        
                       if jobsResponse?.code == 200
                       {
                        self.delegate?.saveRateSuccessfully(msg:jobsResponse?.msg ?? "")

                       }
                      else
                       {
                        self.delegate?.rateFailed(msg: jobsResponse?.msg ?? "")


                       }
                        
                     case let .failure(error):
                         break
                     }
                 }
    }
//    func saveRateApi(parameters: [String : Any]) {
//        self.delegate?.showLoading()
//
//        RateOrderWebServices.saveRateOrderApi(parameters: parameters){ [self] (data, error) in
//                self.delegate?.killLoading()
//
//                if error == nil && data == nil {
//                    print("Connection failed")
//                    self.delegate?.connectionFailed()
//
//                } else if (error != nil)  {
//
//                    self.delegate?.showErrorAlert(error: error ?? "")
//
//                } else if (data?.success == false){
//                    self.delegate?.showErrorAlert(error: data?.msg ?? "")
//
//                }
//                else if (data?.success == true){
//
//
//            self.delegate?.saveRateSuccessfully()
//                }
//
//            }
//        }
    
}
