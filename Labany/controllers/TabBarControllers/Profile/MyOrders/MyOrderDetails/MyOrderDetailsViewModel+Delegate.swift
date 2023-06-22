//
//  MyOrderDetailsViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/2/21.
//

import Foundation

extension MyOrderDetailsVC:MyOrderDetailsViewModelDelegate {
    func getOrderDetailsSuccessfully(order: [OrderModel]) {
        lblAddress.text = order.first?.address?.location
        lblOrderNum.text = "\(order.first?.o_id ?? 0)"
        lblOrderStatus.text = "\(order.first?.order_status_str ?? "")"
        lblDelivaryCost.text =  "\(order.first?.discount ?? 0)" + " ر.س "
        lblTaxCost.text = "\(order.first?.tax ?? 0)" + " ر.س "
        lblTotalCost.text =  "\(order.first?.total ?? 0)" + " ر.س "
        lblDiscount.text = "\(order.first?.discount ?? 0)" + " ر.س "
        lblAmountNum.text = "\(order.first?.wallet_amount ?? 0)" + " ر.س "
        
        
        //MARK:- Total price   = total - (tax+delivary)
        let total = order.first?.total
        let totalMinus = (order.first?.discount)! + (order.first?.tax)!
        let netPrice = total! - totalMinus
        
        lblTotalPrice.text! =  "\(netPrice)" + " ر.س "
        OrderTableView.reloadData()

    }
    
  
   
    func showErrorAlert(error: String) {
        
    }
   
    func connectionFailed() {
        showNoInternetAlert()
    }
    
   
 
    
}
