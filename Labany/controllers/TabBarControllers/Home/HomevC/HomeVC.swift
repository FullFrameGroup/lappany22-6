//
//  HomeVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/9/21.
//

import UIKit
import ImageSlideshow
import LSDialogViewController
import CDAlertView
import PKHUD
import Presentr

class HomeVC: BaseVC {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: TabBarHeader!
    @IBOutlet weak var Hometable: UITableView!
    @IBOutlet weak var pageControl:UIPageControl!

    let slideshow = ImageSlideshow()
    
    var homeVM:HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVM = HomeViewModel(delegate: self)
        
        headerView.delegate = self
        setupTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHomeData), name: NSNotification.Name(rawValue: "editcity"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissToLogin), name: NSNotification.Name(rawValue: "dismissToLogin"), object: nil)

        if let cityId = UserDefaults.standard.value(forKey: "city_id")
        {
            callCategoriesApi(cityId:cityId as? Int ?? 1)
        }
        else
        {
            callCategoriesApi(cityId:1)

        }
    }
    @objc func dismissToLogin()
    {
        login()
        
    }
    @objc func reloadHomeData()
    {
        if let cityId = UserDefaults.standard.value(forKey: "city_id")
        {
            callCategoriesApi(cityId:cityId as! Int)
        }
    }
    
    func callCategoriesApi(cityId:Int){
        if isConnectedToInternet()
        {
            homeVM?.getHomeCategories(cityId:cityId )
        
        }else{
            self.showNoInternetAlert()
        }
    }
    
    // MARK:- Slider
    func createSlideShow(inputSources: [InputSource]) {
        slideshow.frame = containerView.bounds
        self.containerView.addSubview(slideshow)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(gestureRecognizer)
        
        slideshow.slideshowInterval = 4
        slideshow.contentScaleMode = .scaleAspectFill
        slideshow.setImageInputs(inputSources)
        self.pageControl.numberOfPages = homeVM.sliderImages.count
        slideshow.zoomEnabled = true
        slideshow.pageIndicator = nil
        pageControl.tintColor = .black
        slideshow.layer.cornerRadius = 15
        
    }
    
    @objc func didTap() {
        slideshow.presentFullScreenController(from: self)
    }
    
}



extension HomeVC: TabBarHeaderDelegate {
    
    func LocationAction() {
        let VC = ChoseCountryVC()
           
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height)), center: .center) )
            customPresentViewController(presenter, viewController: VC, animated: false, completion: nil)
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

extension HomeVC: HomeViewModelDelegate {

    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
     func showErrorAlert(error:String){
         
         showErrorAlert(message: error)
     }
    func fetchHomeDataSuccessfully() {
        self.Hometable.isHidden = false
        self.Hometable.reloadData()
        self.Hometable.showLoader()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
            self.Hometable.reloadData()

    }
    
    
    func setupSlideShow(inputSources:[InputSource]){
        
        createSlideShow(inputSources: inputSources)
    }

    
    @objc func removeLoader()
    {
        self.Hometable.hideLoader()
    }
}
