//
//  ChoseCountryVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/16/21.
//

import UIKit
import Presentr
import TransitionButton
import DropDown
import LSDialogViewController

//@objc
//protocol ChoseCountryVCDelegate {
//    func dismissDialog()
//}

class ChoseCountryVC: UIViewController {
    
    @IBOutlet weak var btnCountry: TransitionButton!
    @IBOutlet weak var ViewBG: UIView!
//    var delegate:ChoseCountryVCDelegate?

    
    let cityMenu = DropDown()
    var CountryVM:CityViewModel!
    var cityArray : [Cities]?
    var cityNamesArray = [String]()
    var selectedCityId = -1
    var selectedCityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CountryVM = CityViewModel(delegate: self)
        cityMenu.langNum = "1"
        cityMenu.isTransform = true
        
        // adjust height and width of dialog
        view.bounds.size.height = (UIScreen.main.bounds.size.height * 0.5)  - 10
        view.bounds.size.width = (UIScreen.main.bounds.size.width * 0.8)
        view.layer.cornerRadius = 20
        
        CountryVM.getAppCitiesApi()
        DropDownSetUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func callSetCityApi(){
        
        if isConnectedToInternet()
        {
            guard let id = AppDelegate.getUserData()?.id else{return}
            
            let parameters = ["id":id,"city_id":selectedCityId ] as [String : Any]
            
            CountryVM.callSetCityApi(parameters:parameters,cityID:selectedCityId, cityName:selectedCityName)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    @IBAction func tapChooseMenuItem(_ sender: UIButton) {//3
//        btnCountry.startAnimation()
        cityMenu.show()
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
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
        cityMenu.anchorView = btnCountry
        cityMenu.bottomOffset = CGPoint(x: 0, y: btnCountry.frame.size.height) //6
        cityMenu.direction  = .bottom
        
        cityMenu.backgroundColor = .white
        cityMenu.addShadow(color: .lightText)
        cityMenu.layer.cornerRadius = 10
        cityMenu.animationEntranceOptions = .transitionCurlUp
        
        cityMenu.selectionAction = {  (index: Int, item: String) in
            
            self.selectedCityId = self.cityArray![index].city_id!
            self.selectedCityName = self.cityArray![index].city_name_arabic ?? ""
            self.btnCountry.stopAnimation()

            self.btnCountry.setTitle(self.cityNamesArray[index], for: .normal)
            print(self.btnCountry.setTitle(self.cityNamesArray[index], for: .normal))
            
            NotificationCenter.default.post(name: Notification.Name("editeCityName"), object: nil,userInfo: ["cityName":self.cityArray![index].city_name_arabic! ])
            
//            self.delegate?.dismissDialog()
            self.dismiss(animated: true)
            
            if UserDefaults.standard.isLoggedIn()
            {
                self.callSetCityApi()
            }
            else
            {
                // login as vistor
                self.btnCountry.startAnimation()
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UserDefaults.standard.setValue(self.selectedCityId, forKey:"city_id")
                    
                    NotificationCenter.default.post(name: Notification.Name("editcity"),object: nil,userInfo:["cityName":self.selectedCityName, "cityId":self.selectedCityId])
                    self.btnCountry.stopAnimation()
                    self.dismiss(animated: true)
                }
                
            }
            
        }
        
    }
    
    
    
}








