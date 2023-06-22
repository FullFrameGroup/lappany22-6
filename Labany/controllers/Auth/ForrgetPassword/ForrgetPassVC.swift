//
//  ForrgetPassVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/16/21.
//

import UIKit
import DropDown

class ForrgetPassVC: UIViewController {

    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var ConfirnCode: UITextField!
    @IBOutlet weak var headerView: HeaderView!
    
    var forrgetPassVm: ForrgetPassViewModel!
   
    var countryMenu = DropDown()
    var countryNameArray  = ["المملكة العربية السعودية"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- HeaderView
        forrgetPassVm = ForrgetPassViewModel(delegate: self)
        headerView.delegate = self
        headerSetUp()
        
            countryMenu.langNum = "1"
            countryMenu.isTransform = true
        
        countryMenu.direction = .bottom
        countryMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnCountry.setTitle(self.countryNameArray[index], for: .normal)
            
        }
        
        countryMenu.selectionAction = {  (index: Int, item: String) in
            self.btnCountry.setTitle(self.countryNameArray[index], for: .normal)
            
        }
        
        countryMenu.backgroundColor = .red
    }
  

    
    
    
    @IBAction func countryMenueAction(_ sender: Any) {
        
        countryMenu.show()
        countryMenu.hide()
    }
    
    
   
    @IBAction func continueAction(_ sender: Any) {
    }
    

}


extension ForrgetPassVC: HeaderDelegate {
    func dismiss() {
        self.navigationController?.popViewController(animated: true)    }
    
    
}
