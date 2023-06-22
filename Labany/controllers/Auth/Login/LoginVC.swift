//
//  LoginVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/6/21.
//

import UIKit
import PKHUD
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import AuthenticationServices


class LoginVC: UIViewController {
    var loginVM :LoginViewModel!
    var mobileToken : String = ""
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet weak var btnSecure: UIButton!
    @IBOutlet weak var loginProviderStackView: UIStackView!

    var userimageURL = ""
    var userName = ""
    var email = ""
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
      
        loginVM = LoginViewModel(delegate: self)
        
//        self.tfPhone.text = "TestTharrwa147852369@gmail.com"
//        self.tfPassword.text =  "123456"
        
        setupProviderLoginView()
        // FacebookLogin -----------------------
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    @IBAction func loginAction(_ sender:UIButton){
        LoginAuth()
    }

    @IBAction func forrgetPasswordAction(_ sender:UIButton){
        MoveToforrgetPassword()
    
    }
    
    @IBAction func registerAction(_ sender:UIButton){
        moveToRegister()
    }
    
    @IBAction func passSecureAction(_ sender: Any) {
        Secure()
    }
    
    @IBAction func FaceBookLoginAction(_ sender: Any) {
        facebookLogin()
    }
    

    @IBAction func googleSignIn(sender: Any) {
        let signInConfig = GIDConfiguration(clientID: "659471893273-u2b8koei9eftrlgpj7ihqch2hbhd3s48.apps.googleusercontent.com")

        // If sign in succeeded, display the app's main content View.
          GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
              guard error == nil else { return }
              guard let user = user else { return }

              let email = user.profile?.email

              //let fullName = user.profile?.name
              let givenName = user.profile?.givenName
              //let familyName = user.profile?.familyName
              //let profilePicUrl = user.profile?.imageURL(withDimension: 320)
              
              self.showMessage(msg: "تم تسجيل الدخول بنجاح", type: .success)
              if UserDefaults.standard.value(forKey:"DeviceToken") == nil {
                  self.mobileToken = ""
              } else {
                  self.mobileToken = UserDefaults.standard.value(forKey:"DeviceToken") as? String ?? ""
              }
              
              if self.isConnectedToInternet()
              {
                  let parameters = ["userDetail":"\(email ?? "")","device_token": self.mobileToken,"os_version":"iOS","username":givenName ?? ""] as [String : Any]
                  self.loginVM.socialLoginApi(parameters: parameters)
                  
              }else{
                  self.showNoInternetAlert()
              }
             
          }
         
      
    }

}



