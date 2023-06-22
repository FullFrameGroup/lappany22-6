//
//  checkCopuneVC.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import UIKit

class checkCopuneVC: UIViewController {
    
    @IBOutlet weak var tfCoupon :UITextField!
    @IBOutlet weak var viewHeader :HeaderView!
    var checkCopun:CheckCopuneViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCopun = CheckCopuneViewModel(delegate: self)
        
        viewHeader.lblTitle.text = "صرف قسيمة"
        viewHeader.delegate = self
    }
    
    @IBAction func cashingAction(_ sender: Any) {
        
        if tfCoupon.text == ""{
            showMessage(msg: "من فضلك أدخل كود القسيمة", type: .error)
        }else {
            
            let userID = AppDelegate.getUserData()?.id
            
            let cityID = AppDelegate.getUserData()?.city_id
            
            
            
            CallCashingApi(user_id:userID!,coupon_code:tfCoupon.text! ,city_id:cityID ?? 1)
        }
        
    }
    
    
    func CallCashingApi(user_id:Int,coupon_code:String,city_id:Int){
        
        if isConnectedToInternet() {
            let parameters = ["user_id":user_id,"coupon_code":coupon_code,"city_id":city_id] as [String : Any]
            
            checkCopun.callCheckCouponApi(parameters:parameters )
        }else{
            showNoInternetAlert()
        }
    }
    
}

extension checkCopuneVC : HeaderDelegate  {
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
