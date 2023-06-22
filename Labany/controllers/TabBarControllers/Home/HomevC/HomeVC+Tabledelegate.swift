//
//  HomeVC+Tabledelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/18/21.
//

import Foundation
import UIKit
import LSDialogViewController
import Presentr
extension HomeVC : UITableViewDelegate,UITableViewDataSource {
     func setupTableView()
    {
        Hometable.delegate = self
        Hometable.dataSource = self
        Hometable.register(UINib.init(nibName: "HomeTableCell", bundle:nil), forCellReuseIdentifier: "cell")
        
        Hometable.reloadData()
        }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return homeVM.homeData?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableCell
        
        cell.configCell(category:homeVM.homeData?.categories?[indexPath.row])
        
        cell.homeVC = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
        
        
    }
    
    func openDetails(productId:Int,productName:String,ProductTypeId:Int,img:String)
    {
        let vc = ProductDetailVC()

        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height - 200)), center: .center) )
        vc.productID = productId
        vc.productName = productName
        vc.productTypeId = ProductTypeId
        vc.img = img
        customPresentViewController(presenter, viewController: vc, animated: false, completion: nil)

    }
    


    
    
    func dismissDialog() {
        dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }
    


}
