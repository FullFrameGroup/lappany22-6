//
//  PaymentVC+tableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import Foundation
import UIKit
extension  PaymentVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func setupTableView()
    {
        PaymentTable.delegate = self
        PaymentTable.dataSource = self
        PaymentTable.register(UINib.init(nibName: "PaymentCell", bundle:nil), forCellReuseIdentifier: "cell")

        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentVM.visaArr?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Item = paymentVM.visaArr?[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentCell
        
        cell.Configure(visa: Item)
        cell.btnDelete.addTarget(self, action: #selector(deleteAddress), for: .touchUpInside)

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
    @objc func deleteAddress(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: PaymentTable)
        guard let indexPath = PaymentTable.indexPathForRow(at: point) else {
            return
        }
        let userID = AppDelegate.getUserData()?.id

        paymentVM.deleteVisaApi(user_id: userID ?? 0, visa_id: (paymentVM.visaArr?[indexPath.row].visa_id)!)
        paymentVM.visaArr?.remove(at: indexPath.row)
        PaymentTable.deleteRows(at: [indexPath], with: .bottom)
 
    }
    
     
}
