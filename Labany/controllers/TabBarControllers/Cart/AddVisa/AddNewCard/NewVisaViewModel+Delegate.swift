//
//  NewVisaViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/7/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol NewVisaViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserVisaSuccessfully(visa:[VisaModel]?)
   func AddedSuccessfully(msg:String)
}

class NewVisaViewModel {
    weak var delegate: NewVisaViewModelDelegate?
    init(delegate:NewVisaViewModelDelegate?) {
        self.delegate = delegate
    }
    
    
}

//addVisaApi



extension  NewVisaVC : VisaViewModelDelegate {
    func addedSuccessfully(msg: String) {
        showMessage(msg: msg, type: .success)
        NotificationCenter.default.post(name: Notification.Name("openVisaVC"),object: nil,userInfo:nil)
        self.dismiss(animated: true, completion: nil)

    }
    
    func showErrorAlert(error: String) {
        showMessage(msg: error, type: .notification)
        
    }
    func showLoading() {
   startLoadingIndicator()
    }
    
    func killLoading() {
    stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func GetUserVisaSuccessfully(visa: [VisaModel]?) {
    
        
    }
    
    
}
