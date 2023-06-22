//
//  ComplaintsLitsVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//


import Foundation
import UIKit

extension ComplaintsLitsVC : UITableViewDelegate,UITableViewDataSource {
    
    func setupTableView()
    {
        complaintsTable.delegate = self
        complaintsTable.dataSource = self
        complaintsTable.register(UINib.init(nibName: "ComplaintsCell", bundle:nil), forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     
        return complaintsVM.complaintsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComplaintsCell
        let index = complaintsVM.complaintsArr?[indexPath.row]
        cell.configCell(complaint:index)
        
        for _ in  0..<complaintsVM.complaintsArr!.count {
            if index?.is_reviewed == 0 {
                cell.topView.backgroundColor = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
                cell.lblMsg.textColor = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
                
                //if MOLHLanguage.isArabic() == false {
                cell.lblMsg.textAlignment = .right
                cell.lblMsg.text = "نحن نبحث في مشكلتلك ونأمل في حل المشكلة في أقرب وقت";
                
            }else{
                cell.topView.backgroundColor = #colorLiteral(red: 0.2252242267, green: 0.6686077714, blue: 0.3283829689, alpha: 1)
                cell.lblMsg.textColor = #colorLiteral(red: 0.2252242267, green: 0.6686077714, blue: 0.3283829689, alpha: 1)
                cell.lblMsg.textAlignment = .right
                cell.lblMsg.text = "نشكرك لتعاونم معنا "
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    
}
