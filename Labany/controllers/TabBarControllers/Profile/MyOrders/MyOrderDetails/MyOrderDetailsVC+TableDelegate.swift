//
//  MyOrderDetailsVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/2/21.
//

import Foundation
import AnimatableReload

extension MyOrderDetailsVC :UITableViewDelegate , UITableViewDataSource {
    
    func setupTableView()
    {
        OrderTableView.delegate = self
        OrderTableView.dataSource = self
        OrderTableView.register(UINib.init(nibName: "MyorderDetailCell", bundle:nil), forCellReuseIdentifier: "cell")
        AnimatableReload.reload(tableView: OrderTableView, animationDirection: "down")
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return OrderDetailsVM.orderItemsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = OrderDetailsVM.orderItemsArr?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyorderDetailCell
       
        cell.configCell(orderObjc:index!)
        cell.lblRange.text = "\(indexPath.row + 1)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    

    
}
