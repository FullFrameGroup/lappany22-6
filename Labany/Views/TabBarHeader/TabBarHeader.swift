//
//  mainHeader.swift
//  Labany
//
//  Created by Mohamed  Shendy on 5/5/21.
//

import UIKit
import Presentr
protocol TabBarHeaderDelegate : AnyObject {
    
    func LocationAction()
    func  CartAction()
    
}


final class TabBarHeader: UIView {
    
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet  var view: UIView!

    private static let nibName = "TabBarHeader"

    var delegate:TabBarHeaderDelegate?
    var navigationController:UINavigationController!

    override func awakeFromNib(){
        
        initFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(setCity), name: NSNotification.Name(rawValue: "editcity"), object: nil)
        

    }
    
    @objc func setCity(notification: NSNotification){
        UserDefaults.standard.setValue(notification.userInfo!["cityName"]!, forKey:"city_Name")
        btnLocation.setTitle(" \(String(describing: notification.userInfo!["cityName"]!))", for: .normal)
    }
    
    private func initFromNib()
    {
        Bundle.main.loadNibNamed(TabBarHeader.nibName, owner: self, options: nil)
        
        if UserDefaults.standard.value(forKey: "city_Name") != nil {
            let name = UserDefaults.standard.value(forKey: "city_Name") as! String
            
            btnLocation.setTitle(" \(name)", for: .normal)

        }
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
    
    
    @IBAction func CartAction(_ sender: Any) {
        
        delegate?.CartAction()
        
    }
    @IBAction func locationAction(_ sender: Any) {
        delegate?.LocationAction()
    }
    
    
    
}



    


