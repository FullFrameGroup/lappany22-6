//
//  AddressvC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit

extension AddressListVc : UITableViewDelegate,UITableViewDataSource{

    func setupTableView()
    {
        AddressTable.delegate = self
        AddressTable.dataSource = self
        AddressTable.register(UINib.init(nibName: "AddressCell", bundle:nil), forCellReuseIdentifier: "cell")
        
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.addressVM.addressArr?.count == 0  {
            self.AddressTable.setEmptyMessage("لا توجد عناوين")
            
        }else{
            self.AddressTable.restore()
        return addressVM.addressArr?.count ?? 0
        }
        return addressVM.addressArr?.count ?? 0
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressCell
        let index = addressVM.addressArr?[indexPath.row]
         cell.configcell(address: index!)
        
        cell.btnDelete.addTarget(self, action: #selector(deleteAddress), for: .touchUpInside)
       
        cell.btnEdite.tag = indexPath.row
        cell.btnEdite.addTarget(self, action: #selector(updateAddress), for: .touchUpInside)

        return cell
        
    }
    
    @objc func updateAddress(_ sender: UIButton) {
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: AddAddressVC.self)
        
        vc.isUpdate = true
        vc.shippingId = (addressVM.addressArr?[sender.tag].shipping_id) ?? 0
        vc.AlterContact = (addressVM.addressArr?[sender.tag].alter_contact) ?? ""
        vc.alterName = (addressVM.addressArr?[sender.tag].alter_name) ?? ""
        vc.DistrictName = (addressVM.addressArr?[sender.tag].district_name) ?? ""
        vc.selectAddress = (addressVM.addressArr?[sender.tag].location) ?? ""
        vc.selectedLong = "\(Double((addressVM.addressArr?[sender.tag].longitude)!))"
        
        vc.selectedLat = "\(Double((addressVM.addressArr?[sender.tag].latitude)!))"
        vc.selectedCity = (addressVM.addressArr?[sender.tag].city_arabic) ?? ""
        vc.selectedCityId =  (addressVM.addressArr?[sender.tag].city_id) ?? 0
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @objc func deleteAddress(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: AddressTable)
        guard let indexPath = AddressTable.indexPathForRow(at: point) else {
            return
        }
        let userID = AppDelegate.getUserData()?.id

        addressVM.deleteAddressApi(user_id: userID ?? 0, shipping_id: (addressVM.addressArr?[indexPath.row].shipping_id!)!)
        addressVM.addressArr?.remove(at: indexPath.row)
        AddressTable.deleteRows(at: [indexPath], with: .fade)
 
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = addressVM.addressArr?[indexPath.row]
        if fromCart == true {
            NotificationCenter.default.post(name: Notification.Name("selectCartToAddress"),object: nil,userInfo: ["selectedAddress":index?.location as Any,"selectedLong":index?.longitude as Any ,"selectedLat": index?.latitude as Any,"shippingId":index?.shipping_id as Any])
            
            
            UserDefaults.standard.setAddress(value:"\(index?.location ?? "")")
            
            UserDefaults.standard.set("\(index?.location ?? "")", forKey: "userAddress")
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
}
