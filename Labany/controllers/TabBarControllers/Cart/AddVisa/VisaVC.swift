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
import Presentr

class VisaVC: UIViewController {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var btnAddVise: UIButton!
    @IBOutlet var viseTable: UITableView!
    var VisaVM:VisaViewModel!
    var delegate0:CartVC?
    var visaTypeID :Int?
    var itemAmount:Double?
    

    
    @IBOutlet weak var cardOnFileSwitch: UISwitch!
    var cartVC = CartVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VisaVM =  VisaViewModel(delegate: self)
        btnAddVise.roundedBottom(rounded: 20)
        setupTableView()
        
        let userID = AppDelegate.getUserData()?.id
        callVisaApi(user_id: userID ?? 0, visa_type_id: self.visaTypeID ?? 0)
        
        view.bounds.size.height = (UIScreen.main.bounds.size.height * 0.8)  - 100
        view.bounds.size.width = UIScreen.main.bounds.size.width * 0.8
        
       

        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func callVisaApi(user_id:Int,visa_type_id:Int){
        if  isConnectedToInternet(){
            VisaVM.getUserVisaApi(userid: user_id, visaTypeid:visa_type_id )

        }else{
            showNoInternetAlert()
        }
    }
    
    @IBAction func addViseAction(_ sender: Any) {
        
        defer {
            NotificationCenter.default.post(name: Notification.Name("openAddVisa"),object: nil,userInfo:nil)
            NotificationCenter.default.post(name: Notification.Name("visaTypeID"),object: nil,userInfo:["visaTypeID":self.visaTypeID!])
         }
        self.dismiss(animated:false, completion:nil)
        
    }
 
    @IBAction func closeAction(_ sender: UIButton) {//3
        self.dismiss(animated: true, completion: nil)
        
    }
  
    
    

}
