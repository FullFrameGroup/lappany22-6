//
//  TermsViewmodel.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation



import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol TermsViewmodelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func fetchTermsSuccessfully(content:String)
    
}

class TermsViewmodel {
    weak var delegate: TermsViewmodelDelegate?
    init(delegate:TermsViewmodelDelegate?) {
        self.delegate = delegate
    }
    
    func getTerrmsApi() {
        self.delegate?.showLoading()
        CirtyWebServices.getTermsApi(){ [self] (data, error) in
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
                
                
                self.delegate?.fetchTermsSuccessfully(content:data?.data?.content ?? "")
            }
        }
        
    }
}

