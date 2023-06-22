//
//  ChangePasswordVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/16/21.
//

import UIKit
import DropDown
import TransitionButton

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var btnSave: TransitionButton!
    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfnewPassword: UITextField!
    @IBOutlet weak var tfConnfirmPassword: UITextField!
    @IBOutlet weak var btnNewPassSecure: UIButton!
    @IBOutlet weak var btnOldPassSecure: UIButton!
    @IBOutlet weak var btnConfirmPassSecure: UIButton!
    @IBOutlet weak var headerView: HeaderView!

    var changePasswordVM:ChangePassViewModel!
    var id:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- HeaderView
        changePasswordVM = ChangePassViewModel(delegate:self)
        headerView.delegate = self
        headerSetUp()
        
    }

    @IBAction func saveTapped(_ sender: Any) {
        
        Validate()
        
    }
    
    @IBAction func secure1Action(_ sender: Any) {
        Secure1()
    }
    @IBAction func secure2Action(_ sender: Any) {
        Secure2()
    }
    @IBAction func secure3Action(_ sender: Any) {
        Secure3()
    }

}

extension ChangePasswordVC: HeaderDelegate {
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
