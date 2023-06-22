//
//  ComplaintsLitsViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
import PKHUD
import Alamofire
import MIAlertController

protocol ComplaintsLitsViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserComplaintsSuccessfully(complaints:[ComplaitsList])
}

class ComplaintsLitsViewModel {
    weak var delegate: ComplaintsLitsViewModelDelegate?
    init(delegate:ComplaintsLitsViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var complaintsArr:[ComplaitsList]?
    
    func getUserComplaintsApi(user_id:Int) {
        self.delegate?.showLoading()
        ComplaintsListWebServices.getComplaintsListApi(user_id:user_id){ [self] (data, error) in
            self.delegate?.killLoading()
            
            if error == nil && data == nil {
                print("Connection failed")
                self.delegate?.connectionFailed()
                
            } else if (error != nil)  {
                complaintsArr = []
                self.delegate?.showErrorAlert(error: error ?? "")
                
            } else if (data?.success == false){
                self.delegate?.showErrorAlert(error: data?.msg ?? "")
                
            }
            else if (data?.success == true ){
                
                complaintsArr = data?.data
                self.delegate?.GetUserComplaintsSuccessfully(complaints:complaintsArr ?? [])
                
            }
            
        }
    }
}

