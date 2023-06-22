//
//  MyOrdersListVC.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import UIKit

class MyOrdersListVC: UIViewController {

    @IBOutlet var lblNoOrders: UILabel!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var myOrdersTable: UITableView!
    
    var myOrderVM:MyOrdersListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
        headerView.lblTitle.text = "قائمة طلباتي"
    
        myOrderVM = MyOrdersListViewModel(delegate: self)
        setupTableView()
        
        let userID =  AppDelegate.getUserData()?.id!
       
        callGetMyOredersApi(user_Id:userID!)
    }
    
    func callGetMyOredersApi(user_Id:Int){
        
        if isConnectedToInternet(){
            myOrderVM.getMyOrdersList(userId: user_Id)
        }else{
            showMessage(msg: "لايوجد اتصال بالانترنت", type: .error)
        }
    }


}

extension MyOrdersListVC: HeaderDelegate {
    
    func dismiss() {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
