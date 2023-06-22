//
//  CirtyViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/17/21.
//

import Foundation

extension ChoseCountryVC : CityViewModellDelegate {
    func setCitySuccessfully(citName: String, cityId:Int) {
        
        UserDefaults.standard.setValue(cityId, forKey:"city_id")

        NotificationCenter.default.post(name: Notification.Name("editcity"),object: nil,userInfo:["cityName":citName, "cityId":cityId])

        self.dismiss(animated: true, completion: nil)
    }
    
    func showLoading(){
        startLoadingIndicator()
    }
    func killLoading(){
        stopLoadingIndicator()
    }
    func connectionFailed(){
        showNoInternetAlert()
    }
    func showErrorAlert(error:String){
        showErrorAlert(message: error)
    }
    
    func fetchDataSuccessfully(cities:[Cities]){
        cityArray = cities
        loadCitiesMenu()
    }
   
}
