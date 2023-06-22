//
//  ChoseCountryViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/17/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol CityViewModellDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func fetchDataSuccessfully(cities:[Cities])
    func setCitySuccessfully(citName: String, cityId:Int)

}

class CityViewModel {
    weak var delegate: CityViewModellDelegate?
    init(delegate:CityViewModellDelegate?) {
        self.delegate = delegate
    }
    
    var cityArr:[Cities]?


    func getAppCitiesApi() {
//        self.delegate?.showLoading()
        CirtyWebServices.getCitiesApi(){ [self] (data, error) in
//   self.delegate?.killLoading()
   
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


    func callSetCityApi(parameters: [String : Any],cityID:Int, cityName:String) {
//        self.delegate?.showLoading()
        CirtyWebServices.callSetCityApi(parameters: parameters){ [self] (data, error) in
//       self.delegate?.killLoading()
       
       if error == nil && data == nil {
           print("Connection failed")
           self.delegate?.connectionFailed()

       } else if (error != nil)  {
           
          self.delegate?.showErrorAlert(error: error ?? "")

       } else if (data?.success == false){
       self.delegate?.showErrorAlert(error: data?.msg ?? "")
           
       }
           else if (data?.success == true){
               
            self.delegate?.setCitySuccessfully(citName:cityName, cityId:cityID)
           }
       }
   }

}
