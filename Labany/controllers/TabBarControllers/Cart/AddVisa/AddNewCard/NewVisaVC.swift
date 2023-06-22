//
//  MakeComplaintsVC.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import UIKit
import UIKit
import DropDown
import TransitionButton
import LSDialogViewController
import PKHUD

class NewVisaVC: UIViewController {
    
    @IBOutlet var datepicker: UIDatePicker!

    @IBOutlet var bgView: UIView!
    @IBOutlet var btnAddVise: UIButton!
    @IBOutlet var tfUser: UITextField!
    @IBOutlet var tfCardNum: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfDate: UITextField!
    
    
    var VisaVM:VisaViewModel!
    var delegate:VisaVC?
    var visaTypeID :Int?
    var newVisaVM:NewVisaViewModel!
    var selectedDate:String?
    var selectedTime:String?
    var selectedDateForApi:String?
    var selectedTimeForApi:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfPassword.text = "1234567890"
        tfCardNum.text = "1234567890123456"
        tfUser.text = "mohamed"
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle =  .compact
        } else {
            // Fallback on earlier versions
        }
        datepicker.datePickerMode = .date
        datepicker.backgroundColor = .clear
        
//        newVisaVM = NewVisaViewModel(delegate: self)

        VisaVM =  VisaViewModel(delegate: self)
        
        
        btnAddVise.roundedBottom(rounded: 20)
        
        let userID = AppDelegate.getUserData()?.id
        
        callVisaApi(user_id: userID ?? 0, visa_type_id: visaTypeID ?? 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func callAddNewVisaApi(){
        if isConnectedToInternet()
        {
            let id = AppDelegate.getUserData()?.id
            let parameters = ["user_id":id!,"visa_type_id":visaTypeID!,"card_number":tfCardNum.text!,"card_date":selectedDateForApi! ,"secret_code":tfPassword.text!,"Card_holder_name":tfUser.text!] as [String : Any]
            
            
            VisaVM.addVisaApi(parameters:parameters)

        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    func callVisaApi(user_id:Int,visa_type_id:Int){
        if  isConnectedToInternet(){
            VisaVM.getUserVisaApi(userid: user_id, visaTypeid:visa_type_id )
            
        }else{
            showNoInternetAlert()
        }
    }
    
    
 @IBAction func dateAction(_ sender: UIDatePicker) {
 
     let formatter = DateFormatter()
     formatter.dateFormat = "d-M-yyyy"
     formatter.locale = Locale.init(identifier: "ar")
     let date = formatter.string(from: datepicker.date)
    
    print(date)
    selectedDate = date
    self.tfDate.text =  date
//    self.lblDate.text = date
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "d-M-yyyy"
    let date2 = formatter2.string(from: datepicker.date)
    selectedDateForApi = date2
     

 }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        let maxLength = 9
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @IBAction func addViseAction(_ sender: Any) {
        
        if tfUser.text == "" {
            showMessage(msg: "أدخل اسم صاحب البطاقة", type: .error)
            
        }else if tfCardNum.text == "" {
            showMessage(msg: "أدخل رقم البطاقة", type: .error)

        }else if tfCardNum.text!.count < 16 {
            showMessage(msg: "رقم البطاقة لا يقل عن ١٦ رقم", type: .error)

        }else  if tfPassword.text == "" {
            showMessage(msg: "أدخل الرقم السري للبطاقة", type: .error)
        }else if tfDate.text == "" {
            showMessage(msg: "أدخل تاريخ البطاقة", type: .error)
            
        }   else{
            
            callAddNewVisaApi()
            
        }
        
        
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
}
