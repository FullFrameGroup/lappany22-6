//
//  VerifyCodeVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/8/21.
//

import UIKit
import MIAlertController
class VerifyCodeVC: UIViewController {
    
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var firstunderLine: UIView!
    @IBOutlet weak var secondTf: UITextField!
    @IBOutlet weak var secondunderLine: UIView!
    @IBOutlet weak var thirdTf: UITextField!
    @IBOutlet weak var thirdunderLine: UIView!
    @IBOutlet weak var SendView: UIView!
    @IBOutlet weak var fourthTf: UITextField!
    @IBOutlet weak var fourthunderLine: UIView!
    @IBOutlet weak var headerView: HeaderView!
    var verifyCodeVM :VerifyCodeViewModel!
    
    var fromForrget:Bool?
    var id:Int?
    var phone:String = ""
    var otp:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyCodeVM = VerifyCodeViewModel(delegate: self)
        callApi()
        tFDelegate()
    }
    
    func callApi(){
        
        if isConnectedToInternet()
        {
            let parameters = ["id":id!] as [String : Any]
            verifyCodeVM.callVerifyCodeApi(parameters: parameters)
        }else{
            self.showNoInternetAlert()
        }
    }
    
     func callCheckApi(){
        
        if isConnectedToInternet()
        {
            let tfCode = "\(firstTF.text!)\(secondTf.text!)\(thirdTf.text!)\(fourthTf.text!)"
            
            let parameters = ["id":id!,"otp":tfCode] as [String : Any]
     verifyCodeVM.callCheckCodeApi(parameters:parameters)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    
    @IBAction func continueAction(_ sender: Any) {
        callCheckApi()
    }
    

}
