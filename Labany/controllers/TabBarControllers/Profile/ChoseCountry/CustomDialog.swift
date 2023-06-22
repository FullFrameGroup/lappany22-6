//
//  CustomDialog.swift
//  Labany
//
//  Created by Eman Gaber on 5/18/21.
//

import UIKit


class CustomDialog: UIViewController {
   
    var delegate: ProfileVC?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust height and width of dialog
        view.bounds.size.height = (UIScreen.main.bounds.size.height * 0.5)  - 60
        view.bounds.size.width = UIScreen.main.bounds.size.width * 0.8
        view.layer.cornerRadius = 20
    }
    
    // close dialogView
    @IBAction func closeButton(_ sender: AnyObject) {
        delegate?.dismissDialog()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
