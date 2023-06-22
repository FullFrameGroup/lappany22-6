//
//  RateOrderViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation

extension RateOrderVC : RateOrderViewModelDelegate{
    func rateFailed(msg: String) {
        showErrorAlert(message: msg)
    }
    
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
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
    
    func GetUserquestionsSuccessfully() {
        rateTable.reloadData()
    }
    
    func saveRateSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)

        self.dismiss(animated: true, completion: nil)
    }
    
}
