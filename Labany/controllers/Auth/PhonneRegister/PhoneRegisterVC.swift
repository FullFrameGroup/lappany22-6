//
//  PhoneRegisterVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/8/21.
//

import UIKit
import DropDown
import PKHUD

class PhoneRegisterVC: BaseVC {
  
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var headerView: HeaderView!
   
    
    var phoneRegVM :PhoneRegisterViewModel!
    var id:Int?
    var countryMenu = DropDown()
    var countryNameArray  = ["المملكة العربية السعودية"]
    var fromForrget:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPhone.delegate = self
        phoneRegVM = PhoneRegisterViewModel(delegate: self)
        countryMenu.langNum = "1"
        countryMenu.isTransform = true
        
        headerView.delegate = self
        if fromForrget == true {
            headerView.lblTitle.text = "نسيت كلمة المرور"
            
        }else{
            headerView.lblTitle.text = "تسجيل الهاتف"
            
        }
        
        //MARK:-CountryDropDown
        countryMenu.direction = .any
        countryMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnCountry.setTitle(self.countryNameArray[index], for: .normal)
            
        }
        
        countryMenu.selectionAction = {  (index: Int, item: String) in
            self.btnCountry.setTitle(self.countryNameArray[index], for: .normal)
        }
        countryMenu.backgroundColor = .red
    }
    
    
    @IBAction func countryMenueAction(_ sender: Any) {
        
        countryMenu.show()
        countryMenu.hide()
    }
    
    
    @IBAction func continueAction(_ sender: Any) {
        phoneRegister()
        }
    
    
    func phoneRegister(){

        if tfPhone.text == "" {
            showMessage(msg: "أدخل رقم الهاتف", type: .notification)
        }else if fromForrget == true{
            callForrgetPassApi()
        }else{
            callPhoneRegisterApi()
        }
        
    }
    
    func callPhoneRegisterApi(){
        
        if isConnectedToInternet()
        {

            let parameters = ["phone":tfPhone.text!,
                              "id":id!] as [String : Any]
            phoneRegVM.callPhoneregisterApi(parameters: parameters)
            
            
        }else{
            self.showNoInternetAlert()
        }
    }
    
    func callForrgetPassApi() {
        if isConnectedToInternet()
        {

            let parameters = ["phone":tfPhone.text!] as [String : Any]
            phoneRegVM.callForgetPasswordApi(parameters: parameters)
            
            
        }else{
            self.showNoInternetAlert()
        }
    }
    
}


extension PhoneRegisterVC: HeaderDelegate {
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension PhoneRegisterVC: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        print(newString.length)
        return newString.length <= 10
        
    }
}

