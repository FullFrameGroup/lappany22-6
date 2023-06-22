//
//  RegisterVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/6/21.
//

import UIKit
import Presentr
import PKHUD
class RegisterVC: BaseVC, HeaderDelegate {

    var alertMsg: String?

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnSecure: UIButton!
    
    @IBOutlet weak var btnSecure2: UIButton!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var headerView: HeaderView!

    var registerVM :RegisterViewModel!
    var selectedImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerVM = RegisterViewModel(delegate: self)
        SetpupUI()
    }
    
    @IBAction func SignUpAction(_ sender: Any) {
        
        register()
    }
    
    
    @IBAction func TermsAction(_ sender: Any) {
    }
    
    func register(){
        if tfUserName.text == "" {
            showMessage(msg: "من فضلك أدخل الاسم", type: .error)
        }else if tfEmail.text == ""{
            showMessage(msg: "من فضلك أدخل البريد الإلكترونبي", type: .error)

        }else
            //if AppUtils.isValidEmail(testStr: tfEmail.text!){
//            HUD.flash(.label("من فضلك ادخل بريد إلكتروني صحيح"))
//
//        }else
            if tfPassword.text == ""{
                showMessage(msg: "من فضلك أدخل كلمة المرور ", type: .error)

        }else if tfConfirmPassword.text == ""{
            showMessage(msg: "من فضلك أدخل تأكيد كلمة المرور ", type: .error)

        }else if tfPassword.text != tfConfirmPassword.text {
            showMessage(msg: "كلمتا السر غير متطابقة ", type: .error)

        }else{
            callApi()
        }
    }

    func callApi(){
        
        if isConnectedToInternet()
        {
            let parameters = ["username":"\(tfUserName.text!)",
                              "email":"\(tfEmail.text!)",
                              "password":"\(tfPassword.text!)",
                              "confirm_password":"\(tfPassword.text!)",
                              "fcm_token":"1234"
            ] as [String : Any]
            print(parameters)
            
            registerVM.callRegisterApi(parameters: parameters, image: selectedImage)
            
        }else{
            self.showNoInternetAlert()
        }
    }
    
    @IBAction func selectImageAction(sender:UIButton)
    {
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: AttachImageVC.self)
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 50)), height: .custom(size:  200.0), center: .center) )
        
        customPresentViewController(presenter, viewController: vc, animated: false, completion: nil)
        
    }
    
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passSecureAction(_ sender: Any) {
        Secure()
    }
    
    @IBAction func passSecure2Action(_ sender: Any) {
        Secure2()
    }
}

extension RegisterVC: AttachImageDelegate {
    
    func didSelect(image: UIImage?) {
        
        self.imgUser.image = image
        self.selectedImage = image
        
    }
}

