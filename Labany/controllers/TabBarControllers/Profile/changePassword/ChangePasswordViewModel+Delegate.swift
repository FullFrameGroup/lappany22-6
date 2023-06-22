//
//  ChangePassViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
import PKHUD

extension ChangePasswordVC :ChangePassViewModelDelegate {
    func showLoading() {
startLoadingIndicator()
    }
    
    func killLoading() {
 stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
   
    func showErrorAlert(error:String){
        
        showErrorAlert(message: error)
    }
    
    func Successfully() {
        self.dismiss()
        
    }
    
   
    
    
}
