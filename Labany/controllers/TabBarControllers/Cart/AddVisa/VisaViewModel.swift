//
//  VisaViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/3/21.
//

import Foundation

import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController
//import GeideaPaymentSDK
protocol VisaViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserVisaSuccessfully(visa:[VisaModel]?)
    func addedSuccessfully(msg:String)
}

class VisaViewModel {
    weak var delegate: VisaViewModelDelegate?
    init(delegate:VisaViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var visaArr:[VisaModel]?
    var visaObjc:VisaResponse?
    
    func getUserVisaApi(userid:Int,visaTypeid:Int) {
        self.delegate?.showLoading()
        VisaWebServices.getVisaApi(user_id:userid,visa_type_id:visaTypeid){ [self] (data, error) in
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
                visaArr = data?.data
    self.delegate?.GetUserVisaSuccessfully(visa:visaArr ?? [] )
                
            }
            
        }
    }
    
    
    
    
    func addVisaApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
        
        VisaWebServices.addVisaApi(parameters: parameters){ [self] (data, error) in
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
                    
                   
                    self.delegate?.addedSuccessfully(msg:data?.msg ?? "")
                }
    
            }
        }

}
