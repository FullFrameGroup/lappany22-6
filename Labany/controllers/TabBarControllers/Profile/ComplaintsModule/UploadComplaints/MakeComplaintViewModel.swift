//
//  MakeComplaintViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/29/21.
//

import Foundation



import Foundation
import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol MakeComplaintViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func uploadComplaintSuccessfully(msg:String)
    func getTypesSuccessfully(types:[ComplaintTypes])
}


class MakeComplaintViewModel {
    weak var delegate: MakeComplaintViewModelDelegate?
    init(delegate:MakeComplaintViewModelDelegate?) {
        self.delegate = delegate
    }
    var titlesTypeArr:[ComplaintTypes]?


    func uploadComplaintsApi(parameters: [String : Any]) {
        self.delegate?.showLoading()
        
        ComplaintsWebServices.uploadComplaintsApi(parameters: parameters){ [self] (data, error) in
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
                    
                   
            self.delegate?.uploadComplaintSuccessfully(msg:data?.msg ?? "")
                }
    
            }
        }
    
    
    
func getTypesApi() {
        ComplaintsWebServices.getComplaintsTypeApi(){ [self] (data, error) in
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
        titlesTypeArr = data?.data?.complaint_type
        
        
        self.delegate?.getTypesSuccessfully(types: titlesTypeArr ?? [])
       }
   }

}


}



