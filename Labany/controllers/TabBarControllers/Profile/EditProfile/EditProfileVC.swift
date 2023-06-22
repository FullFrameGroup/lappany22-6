//
//  EditProfileVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/11/21.
//

import UIKit
import Presentr
import LSDialogViewController

class EditProfileVC: BaseVC  {
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfUserEmail: UITextField!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var selectedImage:UIImage?
    var ProfileVM : ProfileViewModel!
    var userData:User?
    var profileVC = ProfileVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileVM = ProfileViewModel(delegate:self)
        headerView.delegate = self
        
        
        imgProfile.sd_setImage(with: URL.init(string:userData?.image ?? ""),placeholderImage:UIImage.init(systemName: "person.fill"),completed:
                                {_,_,_,_ in
        })
        
        tfUserName.text! = userData?.username ?? ""
        tfUserEmail.text! = userData?.email ?? ""
        
    }
    
    func callEditProfile(){
        
        if isConnectedToInternet()
        {
             let userId = AppDelegate.getUserData()?.id 
            
            let parameters = ["id":userId ?? 0 ,"username":tfUserName.text!,"email":tfUserEmail.text!] as [String : Any]
           
            ProfileVM?.callEditProfileApi(parameters:parameters,image:selectedImage)
            
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    @IBAction func editProfileData(_ sender: Any) {
//        guard checkIfNotEmpty(for: [tfUserName,tfUserEmail]) else {return}
//        guard AppUtils.isValidEmail(testStr: tfUserEmail.text!) else {return}
//        
        callEditProfile()
    }
    
    @IBAction func termsAction(_ sender: Any) {
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: TermsVC.self)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func selectImageAction(sender:UIButton)
    {
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: AttachImageVC.self)
        vc.delegate = self
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.frame.width)), height: .custom(size:  200.0), center: .center) )
        
        customPresentViewController(presenter, viewController: vc, animated: false, completion: nil)
        
    }
    
}

extension EditProfileVC: HeaderDelegate {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileVC: AttachImageDelegate {
    
    func didSelect(image: UIImage?) {
        
        self.imgProfile.image = image
        self.selectedImage = image
        
    }
}


