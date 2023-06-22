//
//  ForrgetPasswordViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
protocol ChangePassViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func Successfully()
   
}

class ChangePassViewModel {
    weak var delegate: ChangePassViewModelDelegate?
    init(delegate:ChangePassViewModelDelegate?) {
        self.delegate = delegate
    }
    

     func callChangePasswordApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
    ChangePassWebServices.callChangePassApi(parameters: parameters){ [self] (data, error) in
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
                //phoneRegister succ
                
                self.delegate?.Successfully()
            }
        }

    }
}
