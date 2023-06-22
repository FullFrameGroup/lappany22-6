//
//  NotificationsVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import UIKit
import LSDialogViewController
import CDAlertView
import Presentr

class NotificationsVC: BaseVC{
    

    @IBOutlet weak var NotificationTable: UITableView!
    @IBOutlet weak var headerView: TabBarHeader!
    @IBOutlet weak var noNotificationsView: UIView!
    var notificationVM:NotificationViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationVM = NotificationViewModel(delegate:self)
        headerView.delegate = self
        setupTableView()
            
     
    }
    override func viewWillAppear(_ animated: Bool) {
        checkIsLogin()
    }
    
    
    func checkIsLogin(){
        let userId = AppDelegate.getUserData()?.id!

        if UserDefaults.standard.isLoggedIn()
        {
            self.callApi(user_id:userId ?? 0)
            
        }else {
            showLoginAlert()
            
        }
        
    }
    
    
    func callApi(user_id:Int){
        
        if isConnectedToInternet()
        {
            notificationVM.getUserNotificationsApi(user_id:user_id)
        }else{
            self.showNoInternetAlert()
        }
    }
    
}

extension NotificationsVC : TabBarHeaderDelegate {
    
    func showChoseCountryVCDialog(_ animationPattern: LSAnimationPattern) {
        let VC = ChoseCountryVC(nibName: "ChoseCountryVC", bundle: nil)
        
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height)), center: .center) )
            customPresentViewController(presenter, viewController: VC, animated: false, completion: nil)
       // presentDialogViewController(dialogViewController, animationPattern: animationPattern)
    }


    func LocationAction() {
        showChoseCountryVCDialog(.fadeInOut)
        
    }
    
    func CartAction() {
        
            
            if  UserDefaults.standard.isLoggedIn()
            {
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
