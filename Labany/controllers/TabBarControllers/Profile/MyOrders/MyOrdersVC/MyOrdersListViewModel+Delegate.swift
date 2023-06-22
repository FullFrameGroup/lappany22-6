//
//  MyOrdersListViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import Foundation
import PKHUD
extension MyOrdersListVC:MyOrdersListViewModelDelegate{
    func deleteOrderSuccessfully(msg: String) {
        showMessage(msg: msg, type: .success)
        self.myOrdersTable.reloadData()
        self.myOrdersTable.showLoader()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
            self.lblNoOrders.isHidden = true
        
    }
    
    
    func GetMyOrdersSuccessfully(orders: [OrderModel]) {

        if orders.count == 0  {
                
           self.lblNoOrders.isHidden = false
            
        }else{
            self.myOrdersTable.reloadData()
            self.myOrdersTable.showLoader()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
                self.lblNoOrders.isHidden = true
        }

    }
    
//    func GetDataSuccessfully(data: CartItemsList?) {
//        if data?.order?.count == 0  {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3){
//
//                self.lblNoOrders.isHidden = false
//            }
//        }else{
//
//                self.myOrdersTable.reloadData()
//                self.lblNoOrders.isHidden = true
//        }
//    }
    
    func showLoading() {
startLoadingIndicator()
    }
    
    func killLoading() {
stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showErrorAlert(error: String) {
        showErrorAlert(message:error )
    }
    
    func deleteMyOrderSuccessfully() {
        
        
    }
    
    @objc func removeLoader()
    {
        self.myOrdersTable.hideLoader()
    }
   

}
