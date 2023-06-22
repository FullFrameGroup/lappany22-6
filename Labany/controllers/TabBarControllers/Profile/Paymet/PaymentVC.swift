//
//  PaymentVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit

class PaymentVC: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var PaymentTable: UITableView!
    var paymentVM:PaymentViewmodel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentVM = PaymentViewmodel(delegate: self)
        
        headerView.delegate = self
        headerView.lblTitle.text = "طرق الدفع المسجلة"
        setupTableView()
        
        let userID = AppDelegate.getUserData()?.id
        
        callVisaApi(user_id: userID ?? 0, visa_type_id:0)


    }
    
    
    func callVisaApi(user_id:Int,visa_type_id:Int){
        if  isConnectedToInternet(){
            paymentVM.getUserVisaApi(userid: user_id, visaTypeid:visa_type_id )

        }else{
            showNoInternetAlert()
        }
    }
    
}

extension PaymentVC : HeaderDelegate {
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
     
}
