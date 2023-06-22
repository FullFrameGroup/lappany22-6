//
//  WalletViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

//
//  NotificationViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol WalletViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetUserWalletSuccessfully(wallet:[Walletlist],Model:WalletResponse?)
}

class WalletViewModel {
    weak var delegate: WalletViewModelDelegate?
    init(delegate:WalletViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var walletArr:[Walletlist]?
    var wallet:WalletResponse?
    
    func getUserWalletsApi(user_id:Int) {
        self.delegate?.showLoading()
        WalletWebServices.getWalletsApi(user_id:user_id){ [self] (data, error) in
   self.delegate?.killLoading()
   
   if error == nil && data == nil {
       print("Connection failed")
       self.delegate?.connectionFailed()

   } else if (error != nil)  {
       
      self.delegate?.showErrorAlert(error: error ?? "")
       
   } else if (data?.success == false){
   self.delegate?.showErrorAlert(error: data?.msg ?? "")
       
   }
       else if (data?.success == true){
        
        walletArr = data?.data?.wallet_list
        
        wallet = data
        
       
    self.delegate?.GetUserWalletSuccessfully(wallet:walletArr ?? [],Model: wallet)
        
       }

}
}
}
