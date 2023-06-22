//
//  TabbarVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/8/21.
//


import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.init(named: "#dull_red")

        self.navigationController?.navigationBar.isHidden = true
       
        self.selectedIndex = 3 // default open home vc
        
        setBarIcons()
        
        // Disable swipe back gesture in Swift
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Tajawal-Bold", size: 13)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)

    }
    
    func setBarIcons()
    {
        let tabBarItem0 = tabBar.items?[0]
        
        let unselectedImage =  UIImage.init(systemName: "person.circle")
        let selectedImage =  UIImage.init(systemName: "person.circle.fill")
        
        tabBarItem0?.image =   unselectedImage?.withRenderingMode(.alwaysTemplate)
        tabBarItem0?.selectedImage = selectedImage?.withRenderingMode(.alwaysTemplate)
        tabBarItem0?.title = "حسابي".localized
        
        let tabBarItem1 = tabBar.items?[1]
        
        
        let unselectedImage1 =  UIImage.init(systemName: "bell")
        let selectedImage1 =  UIImage.init(systemName: "bell.fill")
        
        tabBarItem1?.image = unselectedImage1?.withRenderingMode(.alwaysTemplate)
        unselectedImage1?.withTintColor(.red)
        
        tabBarItem1?.selectedImage = selectedImage1?.withRenderingMode(.alwaysTemplate)

        
        tabBarItem1?.title =  "الإشعارات".localized
        
        
        let tabBarItem2 = tabBar.items?[2]
        let unselectedImage2 = #imageLiteral(resourceName: "wallet")
        let selectedImage2 = #imageLiteral(resourceName: "group_4039")
        tabBarItem2?.image = unselectedImage2.withRenderingMode(.alwaysOriginal)
        tabBarItem2?.selectedImage = selectedImage2.withRenderingMode(.alwaysOriginal)
        tabBarItem2?.title = "محفظتك".localized
        
        
        
        let tabBarItem3 = tabBar.items?[3]
        let unselectedImage3 =  UIImage.init(systemName: "house")

        let selectedImage3 =  UIImage.init(systemName: "house.fill")

        tabBarItem3?.image = unselectedImage3!.withRenderingMode(.alwaysTemplate)
        tabBarItem3?.selectedImage = selectedImage3!.withRenderingMode(.alwaysTemplate)
        tabBarItem3?.title = "الرئيسية".localized
        
    }
    
    
}
