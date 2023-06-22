//
//  AddressVc.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit
import CDAlertView
class AddressListVc: BaseVC {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var AddressTable: UITableView!
    @IBOutlet weak var lblNoAddress: UILabel!
    var fromCart:Bool?
    var addressVM:AddressViewModel!
    var addressArr:[shippingArrressList]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressVM = AddressViewModel(delegate: self)
        
        headerView.delegate = self
        headerView.lblTitle.text = "العنوان"
        
        setupTableView()
        
        let userId = AppDelegate.getUserData()?.id
        callGetAddressApi(user_id:userId ?? 0)
        
       

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadAddressList),
            name: NSNotification.Name(rawValue: "reloadList"),
            object: nil)
    }
    
    @objc func reloadAddressList(){
        
        let userId = AppDelegate.getUserData()?.id
        callGetAddressApi(user_id:userId ?? 0)
    }

    
    func callGetAddressApi(user_id:Int){
        if isConnectedToInternet(){
            addressVM.getUserAddressApi(user_id: user_id)
        }else{
            self.showNoInternetAlert()
        }
    }
    


    @IBAction func openAddAddressAction(_ sender :UIButton){
        openAddAddress()
    }
  

    func openAddAddress(){
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: AddAddressVC.self)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
}

extension AddressListVc : HeaderDelegate {
    
    func dismiss() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
}
