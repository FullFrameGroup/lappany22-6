//
//  CheckCopuVIewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation

extension checkCopuneVC :CheckCopuneViewModelDelegate {
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
    }
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    func connectionFailed(msg:String) {
//        showErrorAlert(message: msg)
        showNoInternetAlert()
    }
    
    func cashingSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)

        self.navigationController?.popViewController(animated: true)
    }
    
    
}
