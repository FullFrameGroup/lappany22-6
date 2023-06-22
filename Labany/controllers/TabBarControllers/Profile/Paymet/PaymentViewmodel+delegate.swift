//
//  PaymentViewmodel+delegate.swift
//  Labany
//
//  Created by Mac on 11/08/2021.
//

import Foundation


extension PaymentVC :PaymentViewmodelDelegate {
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    func deleteVisaSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)
    }
    
    
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
    }
    
    
    func GetPaymentListSuccessfully(visa: [VisaModel]?) {
        PaymentTable.reloadData()
    }
    func connectionFailed() {
        showNoInternetAlert()    }
    
    
    
}
