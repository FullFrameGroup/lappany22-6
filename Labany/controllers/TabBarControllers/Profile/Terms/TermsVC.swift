//
//  TermsVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit

class TermsVC: UIViewController {
    @IBOutlet weak var tvTerms: UITextView!
    @IBOutlet weak var headerView: HeaderView!
    var termsVM:TermsViewmodel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegate = self
        headerView.lblTitle.text = "الشروط والأحكام" 
        termsVM = TermsViewmodel(delegate:self)
        termsVM.getTerrmsApi()
    }

}

extension TermsVC : HeaderDelegate {
    func dismiss() {
        self.dismiss(animated: true)
    }
    
}

