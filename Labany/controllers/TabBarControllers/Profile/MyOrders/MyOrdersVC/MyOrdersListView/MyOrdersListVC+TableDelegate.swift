//
//  MyOrdersListVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import UIKit
import Presentr
extension MyOrdersListVC :UITableViewDelegate,UITableViewDataSource{
    
    func setupTableView()
    {
        myOrdersTable.delegate = self
        myOrdersTable.dataSource = self
        myOrdersTable.register(UINib.init(nibName: "OrdersCell", bundle:nil), forCellReuseIdentifier: "cell")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myOrderVM.ordersArr?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrdersCell
        
        let order = myOrderVM.ordersArr![indexPath.row]
        cell.configuar(MyOrderObjc: order)
        
           
        cell.btnDelete.addTarget(self, action: #selector(deleteAddress), for: .touchUpInside)
        return cell
        
    }
    
    
    
    @objc func deleteAddress(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myOrdersTable)
        guard let indexPath = myOrdersTable.indexPathForRow(at: point) else {
            return
        }
        let userID = AppDelegate.getUserData()?.id
        
        let orderID = myOrderVM.ordersArr![indexPath.row].o_id
        
        myOrderVM.deleteAddressApi(user_id: userID ?? 0, order_id:orderID!)
        myOrderVM.ordersArr?.remove(at: indexPath.row)
        myOrdersTable.deleteRows(at: [indexPath], with: .bottom)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let itemsCount = myOrderVM.ordersArr?[indexPath.row].cart_item?.count ?? 0
        return CGFloat(80 + (itemsCount * 83))
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  myOrderVM.ordersArr![indexPath.row].is_feedback_given == "no" && myOrderVM.ordersArr![indexPath.row].order_status_str == "placed"
        {
            
            let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height - 200)), center: .center))
            let vc  = RateOrderVC()
            vc.orderId = myOrderVM.ordersArr![indexPath.row].o_id!
            customPresentViewController(presenter, viewController: vc, animated: false, completion: nil)
            
            
        }else {
            
            let orderId = myOrderVM.ordersArr![indexPath.row].o_id
            let vc  = MyOrderDetailsVC()
            vc.OrderID = orderId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
//    func calcTotalPrice(){
//        
//        
//        var totprice = 0.0
//        for item in myOrderVM.ordersArr ?? []
//        {
////            totprice += Double(item.cart_item?.first ?? 0)
//        
//        
//        }
//    }
}

