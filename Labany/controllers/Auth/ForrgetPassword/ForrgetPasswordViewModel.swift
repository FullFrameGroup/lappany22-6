//
//  ForrgetPasswordViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import Foundation
protocol ForrgetPassViewModellDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func Successfully()
   
}

class ForrgetPassViewModel {
    weak var delegate: ForrgetPassViewModellDelegate?
    init(delegate:ForrgetPassViewModellDelegate?) {
        self.delegate = delegate
    }
    

//     func callLoginApi(parameters: [String : Any]) {
//    LoginWebServices.callLoginApi(parameters: parameters){ [self] (data, error) in
//        self.delegate?.killLoading()
//        
//        if error == nil && data == nil {
//            print("Connection failed")
//            self.delegate?.connectionFailed()
//
//        } else if (error != nil)  {
//            
//           self.delegate?.showErrorAlert(error: error ?? "")
//            
//        } else if (data?.success == false){
//        self.delegate?.showErrorAlert(error: data?.msg ?? "")
//            
//        }
//            else if (data?.success == true){
//                //phoneRegister succ
//                
//                self.delegate?.Successfully()
//            }
//        }
//
//    }
}
