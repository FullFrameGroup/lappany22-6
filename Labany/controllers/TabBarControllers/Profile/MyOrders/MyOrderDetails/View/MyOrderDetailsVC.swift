//
//  MyOrderDetails.swift
//  Labany
//
//  Created by Eman Gaber on 8/2/21.
//

import UIKit

class MyOrderDetailsVC: BaseVC {

    @IBOutlet var topView: UIView!
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblTotalCost: UILabel!
    @IBOutlet var lblDelivaryCost: UILabel!
    @IBOutlet var lblTaxCost: UILabel!
    @IBOutlet var lblDiscount: UILabel!
    @IBOutlet var lblTotalPrice: UILabel!
    @IBOutlet var lblOrderNum: UILabel!
    @IBOutlet var lblAmountNum: UILabel!
    @IBOutlet var lblOrderStatus: UILabel!

    @IBOutlet var OrderTableView: UITableView!
    
    var OrderDetailsVM:MyOrderDetailsViewModel!

    var OrderID:Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
        headerView.lblTitle.text = "تفاصيل الطلب"
        OrderDetailsVM = MyOrderDetailsViewModel(delegate: self)

       
        topView.roundedTop(rounded: 15)
        
        let userID = AppDelegate.getUserData()?.id

        callOrderDetailsApi(userId: userID!, orderId: OrderID!)

        setupTableView()

    }
    func callOrderDetailsApi(userId:Int,orderId:Int){
        
        if isConnectedToInternet() {
            OrderDetailsVM.getorderDetails(user_id: userId, order_id:orderId )
        }else{
            showNoInternetAlert()
        }
    }
    
    

}
extension MyOrderDetailsVC : HeaderDelegate {
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
