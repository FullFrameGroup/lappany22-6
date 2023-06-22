//
//  VisaViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/3/21.
//

import Foundation
import PKHUD
extension  VisaVC : VisaViewModelDelegate {
    func addedSuccessfully(msg: String) {
        showMessage(msg: msg, type: .success)
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
    
    func GetUserVisaSuccessfully(visa: [VisaModel]?) {
        viseTable.reloadData()
    }
    
}
