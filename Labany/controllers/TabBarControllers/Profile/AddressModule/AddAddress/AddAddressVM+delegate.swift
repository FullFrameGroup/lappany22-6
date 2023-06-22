//
//  AddAddressVM+delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/28/21.
//

import Foundation
import PKHUD
extension AddAddressVC:AddAddressViewModelDelegate{
    func fetchDataSuccessfully(cities: [Cities]) {
        cityArray = cities
        loadCitiesMenu()
    }
    
    func setCitySuccessfully(msg: String) {
        
    }
    
    func showLoading() {
startLoadingIndicator()
    }
    
    func killLoading() {
stopLoadingIndicator()
    }
    
   
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
        
    }
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func AddAddressSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)
        NotificationCenter.default.post(name: Notification.Name("reloadList"),object: nil,userInfo: nil)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func updateAddressSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)

        NotificationCenter.default.post(name: Notification.Name("reloadList"),object: nil,userInfo: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
