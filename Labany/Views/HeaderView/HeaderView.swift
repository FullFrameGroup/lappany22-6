//
//  HeaderView.swift
//  Labany
//
//  Created by Mohamed Shendy on 5/8/21.
//

import UIKit

protocol HeaderDelegate : class {
   func dismiss()
}

final class HeaderView: UIView {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet  var view: UIView!
    private static let nibName = "HeaderView"

    var delegate:HeaderDelegate?
    
    override func awakeFromNib(){
        initFromNib()
        btnBack.clipsToBounds  =  true
        btnBack.layer.cornerRadius  = 15
      lblTitle.font =  UIFont.init(name: "Tajawal-Bold", size: 17)
      lblTitle.textColor  = .white
    }

    private func initFromNib()
    {
        Bundle.main.loadNibNamed(HeaderView.nibName, owner: self, options: nil)
                view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
        
    }
    
    
    
    
     private func setupLayout() {
         NSLayoutConstraint.activate(
             [
                 view.topAnchor.constraint(equalTo: topAnchor),
                 view.leadingAnchor.constraint(equalTo: leadingAnchor),
                 view.bottomAnchor.constraint(equalTo: bottomAnchor),
                 view.trailingAnchor.constraint(equalTo: trailingAnchor),
             ]
         )
     }
    

   

    @IBAction func backAction(_ sender: Any) {
        delegate?.dismiss()
    }
    
    }


    


