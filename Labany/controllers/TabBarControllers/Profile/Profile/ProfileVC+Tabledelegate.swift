//
//  ProfileVC+Tabledelegate.swift
//  Labany
//
//  Created by Eman Gaber on 5/11/21.
//

import Foundation
import UIKit
import Presentr
import LSDialogViewController
import StoreKit

extension ProfileVC : UITableViewDelegate, UITableViewDataSource  {
    
    func setupTableView()
    {
        ProfileTable.delegate = self
        ProfileTable.dataSource = self
        ProfileTable.register(UINib.init(nibName: "ProfileCell", bundle:nil), forCellReuseIdentifier: "cell")
        
    }
    
    func showChoseCountryVCDialog(_ animationPattern: LSAnimationPattern) {
        let VC = ChoseCountryVC(nibName: "ChoseCountryVC", bundle: nil)
        
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height)), center: .center) )
        customPresentViewController(presenter, viewController: VC, animated: false, completion: nil)
        //        presentDialogViewController(dialogViewController, animationPattern: animationPattern)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        
        cell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        cell.lblTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        cell.icon.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        cell.lblTitle.textAlignment = .right
        
        let indx  = indexPath.row
        
        switch indx {
        case 0:
            cell.lblTitle.text = "صرف قسيمة"
            cell.icon.image = UIImage.init(named: "coupon")
        case 1:
            cell.lblTitle.text = "تغيير كلمة السر"
            cell.icon.image = UIImage.init(named: "privacy")
        case 2:
            cell.lblTitle.text = "المدينة"
            cell.icon.image = UIImage.init(named: "just_arrived")
        case 3:
            cell.lblTitle.text = "العنوان"
            cell.icon.image = UIImage.init(named: "house")
        case 4:
            cell.lblTitle.text = "طرق  الدفع"
            cell.icon.image = UIImage.init(named: "credit_card")
        case 5:
            cell.lblTitle.text = "الشروط والأحكام"
            cell.icon.image = UIImage.init(named: "surface_1")
        case 6:
            cell.lblTitle.text = "إتصل بنا"
            cell.icon.image = UIImage.init(named: "information")
        case 7:
            cell.lblTitle.text = "تقييمك يهمنا"
            cell.icon.image = UIImage.init(named: "favorite")
        case 8:
            cell.lblTitle.text = "رفع شكوى"
            cell.icon.image = UIImage.init(named: "error")
        case 9:
            cell.lblTitle.text = "طلباتي"
            cell.icon.image = UIImage.init(named: "credit_card")
            
            
        case 10:
            
            if !UserDefaults.standard.isLoggedIn()
            {
                cell.lblTitle.text = "تسجيل الدخول"
                cell.icon.image = UIImage.init(named: "xmlid_2")
                
            }
            else
            {
                cell.lblTitle.text = "تسجيل خروج"
                cell.icon.image = UIImage.init(named: "xmlid_2")
                
            }
        
        case 11:
            cell.lblTitle.text = "حذف الحساب"
            cell.icon.image = UIImage.init(named: "delete.left")
            
            
        default:
            break
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indx  = indexPath.row
        
        switch indx {
        case 0:
            if UserDefaults.standard.isLoggedIn(){
                let vc = checkCopuneVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                showLoginAlert()
            }
            
        case 1:
            if UserDefaults.standard.isLoggedIn(){
                
                let vc = AppStoryboard.Profile.viewController(viewControllerClass: ChangePasswordVC.self)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                showLoginAlert()
            }
            
        case 2:
            
            showChoseCountryVCDialog(.fadeInOut)
            
        case 3 :
            if UserDefaults.standard.isLoggedIn(){
                let vc = AppStoryboard.Profile.viewController(viewControllerClass: AddressListVc.self)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                showLoginAlert()
            }
            
        case 4 :
            if UserDefaults.standard.isLoggedIn(){
                let vc = AppStoryboard.Profile.viewController(viewControllerClass: PaymentVC.self)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                showLoginAlert()
            }
            
        case 5 :
            if UserDefaults.standard.isLoggedIn(){
                let vc = AppStoryboard.Profile.viewController(viewControllerClass: TermsVC.self)

                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            }else{
                showLoginAlert()
            }
            
        case 6:
            
            self.callNumber(phoneNumber: "966561455500")
            
        case 7 :
            if #available( iOS 10.3,*){
                SKStoreReviewController.requestReview()
            }
            
        case 8 :
            if UserDefaults.standard.isLoggedIn(){
                let vc = ComplaintsLitsVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                showLoginAlert()
            }
            
            
        case 9 :
            if UserDefaults.standard.isLoggedIn() {
                let vc = MyOrdersListVC()
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                showLoginAlert()
            }
            
        case 10 :
            if  UserDefaults.standard.value(forKey: "isLogin") != nil {
                showLogoutAlert()
            }else {
                login()
            }
        case 11 :
            if  UserDefaults.standard.value(forKey: "isLogin") != nil {
               
                showDeletAccountAlert()
            }else {
                login()
            }
        default:
            break
        }
        
    }
    
    
    
    
    private func callNumber(phoneNumber: String) {
        if let url = URL(string: "telprompt://\(phoneNumber)") {
            let application = UIApplication.shared
            guard application.canOpenURL(url) else {
                return
            }
            application.open(url, options: [:], completionHandler: nil)
        }
    }
    

    
    fileprivate func rateApp(appId: String) {
        openUrl("itms-apps://apple.com/app/" + appId)
    }
    
    fileprivate func openUrl(_ urlString:String) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
 
}
