//
//  ProfileVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/11/21.
//

import UIKit
import LSDialogViewController
import CDAlertView

class ProfileVC: BaseVC {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblWalletAmount: UILabel!
    @IBOutlet weak var ProfileTable: UITableView!
    @IBOutlet weak var headerView: TabBarHeader!
    @IBOutlet weak var scrolViewHeight: NSLayoutConstraint!
    
    var userData:User?
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    let titleArr = ["صرف قسيمة","تغيير كلمة السر", "المدينة","","","","","",""]
   
    var ProfileVM : ProfileViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        checkIsLogin()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileVM = ProfileViewModel(delegate:self)
        headerView.delegate = self
        setupTableView()
        TableHeight()
    }

    func CheckUserData(){
        if userData == nil
        {
            callGetUserDataApi()
            setDataInView()
        }
    }
    
    func checkIsLogin(){
        
        if UserDefaults.standard.isLoggedIn()
        {
            CheckUserData()
            callGetUserDataApi()
        }else{
            lblUserName.text = "اسم المستخدم"
            lblUserEmail.text = "البريد الإلكتروني "
            lblWalletAmount.text = "0.0"
            
            showLoginAlert()
        }
    }
    
    
    func callGetUserDataApi(){
        
        if isConnectedToInternet()
        {
            
            let userId = AppDelegate.getUserData()?.id!
            
            let parameters = ["id":userId ?? 0] as [String : Any]
            ProfileVM.getProfileDataApi(parameters:parameters)
            
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    func deleteAccoutApi(user_id:Int){
        if isConnectedToInternet(){
            ProfileVM.getDeleteAccountApi(user_id: user_id)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    func LogoutApi(){
        
        if isConnectedToInternet()
        {
            guard let id = AppDelegate.getUserData()?.id else{return}
            let parameters = ["id":id] as [String : Any]
            print(parameters)
            
            ProfileVM.callLogoutApi(parameters: parameters)
            
        }else{
            self.showNoInternetAlert()
        }
    }
    
    @IBAction func editProfile(_ sender: Any) {
        
        if UserDefaults.standard.isLoggedIn() {
            
            let vc = AppStoryboard.Profile.viewController(viewControllerClass: EditProfileVC.self)
            vc.userData = self.userData
            vc.profileVC = self
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true, completion: nil)
            
        }else{
            showLoginAlert()
        }
            
    }
    
    func TableHeight(){
        tableHeight.constant = CGFloat( (12 * 60) + 170)
        
        scrolViewHeight.constant += (tableHeight.constant - 725)
        self.loadViewIfNeeded()
    }
    
}

extension ProfileVC : TabBarHeaderDelegate {
    
    func LocationAction() {
        showChoseCountryVCDialog(.fadeInOut)
        
    }
    
    func CartAction() {
        
        if  UserDefaults.standard.isLoggedIn() {
            let vc = AppStoryboard.Cart.viewController(viewControllerClass: CartVC.self)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }else {
            showLoginAlert()
            
        }
    }
    
    
    
    func showLoginAlert(){
        let alert = CDAlertView(title: "", message:"هل تريد تسجيل الدخول؟", type: .notification)
        
        alert.circleFillColor = #colorLiteral(red: 0.9751031995, green: 0.7038634419, blue: 0.2710191011, alpha: 1)
        
        let yesAction = CDAlertViewAction(title:"نعم") { _ in
            self.login()
            
            return true
        }
        yesAction.buttonTextColor = .label
        
        
        let noAction = CDAlertViewAction(title:"لا") { _ in
            return true
        }
        noAction.buttonTextColor = .label
        alert.add(action: yesAction)
        alert.add(action: noAction)
        alert.show()
        
    }
    
    
}


