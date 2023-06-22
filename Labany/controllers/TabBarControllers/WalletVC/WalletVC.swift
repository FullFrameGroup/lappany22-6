//
//  WalletVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import UIKit
import LSDialogViewController
import CDAlertView
import Presentr

class WalletVC: UIViewController {

    @IBOutlet weak var headerView: TabBarHeader!
    @IBOutlet weak var vwbalance: UIView!
    @IBOutlet weak var noTransactionsView: UIView!
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet weak var walletTable: UITableView!

    var walletVM : WalletViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletVM = WalletViewModel(delegate: self)
        vwbalance.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        
        headerView.delegate = self
        setupTableView()
        SetUILocalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIsLogin()
        SetUILocalize()
    }
    
    func checkIsLogin(){
        

        if UserDefaults.standard.isLoggedIn()
        {
        guard let userID = AppDelegate.getUserData()?.id else{return}
        callUserWalletsApi(user_id:userID)
        }else {
            showLoginAlert()
            
        }
        
    }
    
    func callUserWalletsApi(user_id:Int){
        if isConnectedToInternet(){
            walletVM.getUserWalletsApi(user_id:user_id)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    func SetUILocalize(){
//        if MOLHLanguage.isArabic() {
//            lblWalletBalance.textAlignment = .right
//        }else{
//            lblWalletBalance.textAlignment = .left
//        }
    }

}


extension WalletVC : TabBarHeaderDelegate {
    
    func showChoseCountryVCDialog(_ animationPattern: LSAnimationPattern) {
        let VC = ChoseCountryVC(nibName: "ChoseCountryVC", bundle: nil)
        
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height)), center: .center) )
            customPresentViewController(presenter, viewController: VC, animated: false, completion: nil)
//        presentDialogViewController(dialogViewController, animationPattern: animationPattern)
    }


    func LocationAction() {
        showChoseCountryVCDialog(.fadeInOut)
        
    }
    
    func CartAction() {
        
        if  UserDefaults.standard.isLoggedIn() {
            let vc = AppStoryboard.Cart.viewController(viewControllerClass: CartVC.self)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else
        {
            showLoginAlert()
        }
    }
    
    
    
    func showLoginAlert(){
        let alert = CDAlertView(title: "", message:"يجب تسجيل  الدخول أولاً", type: .notification)
        
        alert.circleFillColor = #colorLiteral(red: 0.9751031995, green: 0.7038634419, blue: 0.2710191011, alpha: 1)
        
        let yesAction = CDAlertViewAction(title:"نعم") { _ in
            //print("yeeee")
            
                self.login()
            
            
            return true
        }
        yesAction.buttonTextColor = .label
        
        
        let noAction = CDAlertViewAction(title:"لا") { _ in
            //print("nooooo")
            return true
        }
        noAction.buttonTextColor = .label
        alert.add(action: yesAction)
        alert.add(action: noAction)
        alert.show()
        
    }
    
    
    func login(){
        let vc = AppStoryboard.Main.viewController(viewControllerClass: SplashVC.self)
         let nav = UINavigationController.init(rootViewController:vc)
        self.navigationController?.popViewController(animated: true)

    
    }
    
}
