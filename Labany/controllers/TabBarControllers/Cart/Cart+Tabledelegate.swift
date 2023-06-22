//
//  Cart+Tabledelegate.swift
//  Labany
//
//  Created by Eman Gaber on 6/30/21.
//

import Foundation
import UIKit
import AnimatableReload



extension CartVC :UITableViewDelegate , UITableViewDataSource {
    
    func setupTableView()
    {
        cartTable.delegate = self
        cartTable.dataSource = self
        cartTable.register(UINib.init(nibName: "CartTableCell", bundle:nil), forCellReuseIdentifier: "cell")
        
        AnimatableReload.reload(tableView: cartTable, animationDirection: "down")
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return cartVM.cartItemsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cartItem = cartVM.cartItemsArr?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableCell
        cell.btndelete.addTarget(self, action: #selector(deleteAddress), for: .touchUpInside)

        cell.btnPlus.tag = indexPath.row
        cell.btnminuus.tag = indexPath.row
        cell.lblQuantity.tag = indexPath.row
        cell.selectionStyle = .none
        cell.cartVC = self
        
        cell.configuarCart(cartItem: cartItem,index: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    
    
    
    @objc func deleteAddress(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: cartTable)
        guard let indexPath = cartTable.indexPathForRow(at: point) else {
            return
        }
        let userID = AppDelegate.getUserData()?.id
        let cartItem = cartVM.cartItemsArr?[indexPath.row].cart_item_id
        let cartID = cartVM.cartData?.cart_id
        
        cartVM.deleteItemApi(user_id: userID!, cartId: cartID!, cartItemId: cartItem!)
        cartVM.cartItemsArr?.remove(at: indexPath.row)
        cartTable.deleteRows(at: [indexPath], with: .fade)
    }
    
}
