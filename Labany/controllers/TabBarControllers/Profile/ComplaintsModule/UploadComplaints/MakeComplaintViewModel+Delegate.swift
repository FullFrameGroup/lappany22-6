//
//  MakeComplaintViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/29/21.
//

import Foundation
import LSDialogViewController
import PKHUD
extension MakeComplaintsVC:MakeComplaintViewModelDelegate{

    func getTypesSuccessfully(types: [ComplaintTypes]) {
    titlesTypeArr = types
    loadTypesMenu()
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

func uploadComplaintSuccessfully(msg: String) {
    showMessage(msg: msg, type: .success)

    NotificationCenter.default.post(name: Notification.Name("reloadComplaintsList"),object: nil,userInfo: nil)

    self.dismiss(animated: true, completion: nil)
    
    
}

    func showErrorAlert(error: String) {
        
    }
    
    
}
