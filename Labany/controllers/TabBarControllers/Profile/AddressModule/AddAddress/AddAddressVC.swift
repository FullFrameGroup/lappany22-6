//
//  AddAddressVC.swift
//  Labany
//
//  Created by Eman Gaber on 7/28/21.
//

import UIKit
import DropDown
import CDAlertView
class AddAddressVC: UIViewController {
    
    @IBOutlet weak var lbAddress : UILabel!
    @IBOutlet weak var btnCity : UIButton!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var btnAddAddress: UIButton!
    @IBOutlet var tfDistrictName: UITextField!
    @IBOutlet var tfAlterName: UITextField!
    @IBOutlet var tfAlterContact: UITextField!
    
    var selectedCity = ""
    var alterName = ""
    var DistrictName = ""
    var AlterContact = ""
    var selectAddress = ""
    var selectedLong = ""
    var selectedLat = ""
    var isUpdate:Bool?
    var shippingId:Int?
    let cityMenu = DropDown()
    var cityArray : [Cities]?
    var cityNamesArray = [String]()
    var selectedCityId = -1
    var addAddressVM:AddAddressViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            cityMenu.langNum = "1"
            cityMenu.isTransform = true
        
        
        if isUpdate == true {
            setdata()
            btnAddAddress.setTitle("تعديل عنوان", for: .normal)
            headerView.lblTitle.text = "تعديل عنوان"
        }else{
            btnAddAddress.setTitle("إضافة عنوان", for: .normal)
            headerView.lblTitle.text = "إضافة عنوان"
        }
        
        
        headerView.delegate = self
        addAddressVM = AddAddressViewModel(delegate: self)
        addAddressVM.getAppCitiesApi()
        DropDownSetUp()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.SetSelectedAddressAction),
            name: NSNotification.Name(rawValue: "setSelectedAddress"),
            object: nil)
        
    }
    
    func setdata(){
        tfAlterName.text = alterName
        tfDistrictName.text = DistrictName
        tfAlterContact.text = AlterContact
        lbAddress.text = selectAddress
        btnCity.setTitle(selectedCity, for: .normal)
    }
    
    @IBAction func openSelectAddressAction(_ sender: Any) {
        openMapAction()
    }
   
    
   
    
    func callAddAddressApi(){
        if isConnectedToInternet()
        {
             let id = AppDelegate.getUserData()?.id
            let parameters = ["user_id":id,"location":selectAddress,"district_name":tfDistrictName.text!,"city":selectedCityId ,"alter_name":tfAlterName.text!,"alter_contact":tfAlterContact.text!,"latitude":selectedLat,"longitude":selectedLong] as [String : Any]
           
            
            let parameters1 = ["shipping_id":shippingId ?? 0,"user_id":id,"location":selectAddress,"district_name":tfDistrictName.text!,"city":selectedCityId ,"alter_name":tfAlterName.text!,"alter_contact":tfAlterContact.text!,"latitude":selectedLat,"longitude":selectedLong] as [String : Any]
            
            if isUpdate == true {
                addAddressVM.updateAddressApi(parameters:parameters1)

            }else{
                addAddressVM.addAddressApi(parameters:parameters)

            }
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
  
    @IBAction func selectCityAction(_ sender: Any) {
        cityMenu.show()
    }
    

    
    @IBAction func saveAddressAction(_ sender: Any) {
        if selectedCityId  ==  -1  {
            showMessage(msg: "اختر المدينة", type: .error)
        }else if lbAddress.text  == "" {
            showMessage(msg: "اختر العنوان من الخريطة", type: .error)
        }else if tfDistrictName.text == "" {
            showMessage(msg: "أدخل اسم الحي", type: .error)

        }else if tfAlterName.text == "" {
            showMessage(msg: "أدخل اسم المستلم", type: .error)

        }else if tfAlterContact.text == "" {
            showMessage(msg: "أدخل رقم المستلم", type: .error)
      
        }else{
            callAddAddressApi()
        }
    }
}

extension AddAddressVC :HeaderDelegate {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
