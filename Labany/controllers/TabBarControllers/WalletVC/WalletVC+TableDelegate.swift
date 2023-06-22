//
//  WalletVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import Foundation
import UIKit

extension WalletVC : UITableViewDelegate,UITableViewDataSource {
    
    
    func setupTableView()
    {
        walletTable.delegate = self
        walletTable.dataSource = self
        walletTable.register(UINib.init(nibName: "WalletCell", bundle:nil), forCellReuseIdentifier: "cell")
        
        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if walletVM.walletArr?.count != nil
        {
            noTransactionsView.isHidden = true
        }
        else
        {
            noTransactionsView.isHidden = false
        }
        
        return walletVM.walletArr?.count ?? 0
        
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WalletCell
        cell.configCell(wallet:(walletVM.walletArr?[indexPath.row])!)
        
        let index = walletVM.walletArr?[indexPath.row]
     
        for _ in  0..<walletVM.walletArr!.count {
            let perfixitem = "\(String(describing: index?.amount))"
            if  perfixitem.contains("-"){
                cell.img.setImage(UIImage.init(systemName: "arrow.down"), for: .normal)
                cell.img.backgroundColor = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
            }else{
                cell.img.setImage(UIImage.init(systemName: "arrow.up"), for: .normal)
                cell.img.backgroundColor = #colorLiteral(red: 0.9762124419, green: 0.6803825498, blue: 0.2283066511, alpha: 1)
            }

        }
        

        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 102
    }
    
    
}
