//
//  CheckCopuneViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation

protocol CheckCopuneViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed(msg:String)
    func showErrorAlert(error:String)
    func cashingSuccessfully(msg:String)
   
}

class CheckCopuneViewModel {
    weak var delegate: CheckCopuneViewModelDelegate?
    init(delegate:CheckCopuneViewModelDelegate?) {
        self.delegate = delegate
    }
    

     func callCheckCouponApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
        CheckCopunWebService.callCheckWalletCouponApi(parameters: parameters){ [self] (data, error) in
        self.delegate?.killLoading()
        
        if error == nil && data == nil {
            print("Connection failed")
            self.delegate?.connectionFailed(msg:"Connection failed")

        } else if (error != nil) {
            
           self.delegate?.showErrorAlert(error: error ?? "")
            
        } else if (data?.success == false){
        self.delegate?.showErrorAlert(error: data?.msg ?? "")
            
        }
            else if (data?.success == true){
                //phoneRegister succ
                
                self.delegate?.cashingSuccessfully(msg: data?.msg ?? "")
            }
        }

    }
    
}
