//
//  RateUSVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit

class RateUsVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.addShadow(color: .lightGray)
        
    }
        
    @IBAction func dismissAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
