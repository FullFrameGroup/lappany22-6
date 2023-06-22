//
//  WalletViewModel+Delegatee.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
import PKHUD

extension WalletVC:WalletViewModelDelegate {
    
    func showErrorAlert(error: String) {
        showErrorAlert(message:error)
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
    
    func GetUserWalletSuccessfully(wallet: [Walletlist], Model: WalletResponse?) {
        self.walletTable.isHidden = false
        self.walletTable.reloadData()
        self.walletTable.showLoader()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
        
        lblWalletBalance.text = "\(String(describing: Model?.data?.wallet_amount ?? 0.0) + "ريال")"
        
        
    }
    @objc func removeLoader()
    {
        self.walletTable.hideLoader()
    }
    
    
}
