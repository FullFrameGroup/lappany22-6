//
//  AddAddressViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/28/21.
//


import Foundation
import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol AddAddressViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func AddAddressSuccessfully(msg:String)
    func fetchDataSuccessfully(cities:[Cities])
    func setCitySuccessfully(msg:String)
    func updateAddressSuccessfully(msg:String)
}


class AddAddressViewModel {
    weak var delegate: AddAddressViewModelDelegate?
    init(delegate:AddAddressViewModelDelegate?) {
        self.delegate = delegate
    }
   
    var cityArr:[Cities]?
    
    func getAppCitiesApi() {
        self.delegate?.showLoading()
        CirtyWebServices.getCitiesApi(){ [self] (data, error) in
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
                cityArr = data?.data?.cities
                
                self.delegate?.fetchDataSuccessfully(cities:cityArr ?? [])
            }
        }
        
    }

    
func addAddressApi(parameters: [String : Any]) {
    self.delegate?.showLoading()
    AddressWebServices.addAddressApi(parameters: parameters){ [self] (data, error) in
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
                
                self.delegate?.AddAddressSuccessfully(msg:data?.msg ?? "")
            }
            
        }
    }
    
    
func updateAddressApi(parameters: [String : Any]) {
    self.delegate?.showLoading()
    AddressWebServices.updateAddressApi(parameters: parameters){ [self] (data, error) in
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
                
                self.delegate?.updateAddressSuccessfully(msg:data?.msg ?? "")
            }
            
        }
    }
}



