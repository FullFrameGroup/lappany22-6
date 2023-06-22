//
//  ResetPasswordVC.swift
//  Labany
//
//  Created by Eman Gaber on 7/13/21.
//

import UIKit

class ResetPasswordVC: BaseVC {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btnSecure1: UIButton!
    @IBOutlet var btnSecure2: UIButton!
    @IBOutlet weak var headerView: HeaderView!
    var phone = ""
    var ResetVM : ResetPassViewMode!
    var alertMsg: String?
    var otp:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegate = self
        headerSetUp()
        
        ResetVM = ResetPassViewMode(delegate: self)
    }

   
    
    @IBAction func confirmPassSecureAction(_ sender: Any) {
        Secure2()
    }
    
    @IBAction func passSecureAction(_ sender: Any) {
        Secure1()
    }
    
    
    
    @IBAction func savePasswordAction(_ sender: Any) {
       
        if tfPassword.text == ""  {
            showMessage(msg: "أدخل كلمة المور", type:.error)
        }else if  tfConfirmPassword.text == ""{
            showMessage(msg: "أدخل تأكيد كلمة المور", type:.error)
        } else if  tfPassword.text != tfConfirmPassword.text{
            showMessage(msg: "كلمتا المرور غير متطابقتان", type:.error)
        }else {
            if isConnectedToInternet()
            {
                
                let parameters = ["phone":phone,"otp":otp ?? 0,"new_password":tfPassword.text!] as [String : Any]
                ResetVM.callReSetPassworrdApi(parameters: parameters)
            }else{
                self.showNoInternetAlert()
            }
        }
        
        

    }
    
}


extension ResetPasswordVC:HeaderDelegate{
  func dismiss(){
      self.navigationController?.popViewController(animated: true)

    }
}
