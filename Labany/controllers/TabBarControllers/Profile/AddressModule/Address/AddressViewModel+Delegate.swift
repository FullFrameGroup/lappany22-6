//
//  AddressViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation


extension AddressListVc:AddressViewModelDelegate {
    func deleteAddressSuccessfully() {
            self.AddressTable.reloadData()
        let userId = AppDelegate.getUserData()?.id
        addressVM.getUserAddressApi(user_id: userId ?? 0)
    }
    
  
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
    
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func GetUserAddressSuccessfully(address: [shippingArrressList]) {
        addressVM.addressArr = address
            self.AddressTable.reloadData()
            self.AddressTable.showLoader()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
    }
    @objc func removeLoader()
    {
        self.AddressTable.hideLoader()
    }
    
    
}
