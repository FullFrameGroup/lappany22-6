//
//  Navigator+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/28/21.
//

import Foundation
import DropDown

extension AddAddressVC {
    
    @objc func SetSelectedAddressAction(notification: NSNotification)  {
        lbAddress.text = (notification.userInfo!["selectedAddress"] as! String)
        selectAddress = notification.userInfo!["selectedAddress"] as! String
        selectedLong = notification.userInfo!["selectedLong"] as! String
        selectedLat = notification.userInfo!["selectedLat"] as! String
    }
    
    // Setup DropDown Menue ------------
    func loadCitiesMenu()
    {
        var names : [String] = []
        for city in cityArray ?? []
        {
            names.append(city.city_name_arabic ?? "")
        }
        cityMenu.dataSource = names
        cityNamesArray = names
    }
    
    func DropDownSetUp()
    {
        cityMenu.anchorView = btnCity //5
        cityMenu.bottomOffset = CGPoint(x: 0, y: btnCity.frame.size.height) //6
        //7
        cityMenu.direction  = .bottom
        cityMenu.backgroundColor = .white
        cityMenu.addShadow(color: .lightText)
        cityMenu.layer.cornerRadius = 10
        cityMenu.animationEntranceOptions = .curveEaseIn
        cityMenu.selectionAction = {  (index: Int, item: String) in
        self.btnCity.setTitle(self.cityNamesArray[index], for: .normal)
        self.selectedCityId = self.cityArray![index].city_id!
        }
    }
    
    //OpenMApView----------------
    func openMapAction(){
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: SelectAddressVC.self)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}
