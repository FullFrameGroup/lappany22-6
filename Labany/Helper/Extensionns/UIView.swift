//
//  UIView + Border.swift
//  Drovox Passenger
//
//  Created by MacBook on 2/23/21.
//

import Foundation
import UIKit

enum BorderSide {
    case top, bottom, left, right
}




extension UIView {
    func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        if let existedBorder = self.viewWithTag(1234) {
            existedBorder.backgroundColor = color
        } else {
            let border = UIView()
            border.tag = 1234
            border.translatesAutoresizingMaskIntoConstraints = false
            border.backgroundColor = color
            self.addSubview(border)
            
            let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
            let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
            let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
            let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
            let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
            let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)
            
            
            switch side {
            case .top:
                NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
            case .right:
                NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
            case .bottom:
                NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
            case .left:
                NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
            }
        }
    }
    
    func setHeight(_ h:CGFloat, animateTime:TimeInterval? = nil) {
        
        if let c = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
            c.constant = CGFloat(h)
            
            if let animateTime = animateTime {
                UIView.animate(withDuration: animateTime) {
                    self.superview?.layoutIfNeeded()
                } completion: { (_) in
                    self.subviews.forEach { (view) in
                        view.isHidden = h == 0
                    }
                    self.isHidden = h == 0
                }
            }
            else {
                self.superview?.layoutIfNeeded()
            }
        }
       
    }
    
    func addCornersAndBorders(radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil) {
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        self.layer.cornerRadius = radius

        self.clipsToBounds = true
        self.layer.masksToBounds = true

    }
    
    func roundedTop(rounded: Int){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(integerLiteral: rounded)
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    func roundedBottom(rounded: Int ){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(integerLiteral: rounded)
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }
    
    func roundedCorners(rounded: Int, andBottom: Bool = false){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(integerLiteral: rounded)
        if #available(iOS 11.0, *) {
            if !andBottom {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    
    func addShadow(color: UIColor, bottomOrTop: Bool = false, radius: CGFloat = 2, height: CGFloat = 3) {
        // These below line makes the trick to draw shadow with corner radius
        self.layer.masksToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: height, height:  bottomOrTop ? height : height * -1)
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.4
    }
    
    func addFadeShadow() {
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false

    }
}

extension  UIView {


    // Snapshot utilities
      func snapshotView(view: UIView, afterUpdates: Bool) -> UIView {
        let snapshot = view.snapshotView(afterScreenUpdates: afterUpdates)
        self.addSubview(snapshot!)
        snapshot!.frame = convert(view.bounds, from: view)
        return snapshot!
      }
      
      func snapshotViews(views: [UIView], afterUpdates: Bool) -> [UIView] {
        return views.map { snapshotView(view: $0, afterUpdates: afterUpdates) }
      }
      
    
    

        func addShadowImage(parentview:UIView, shadowColor : UIColor){
                    
//
                    
                            //  ADD Shadow right &Bottom & left
            //                parentview.layer.shadowColor = shadowColor.cgColor
            //
            //                parentview.layer.masksToBounds = false
            //                parentview.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            //                parentview.layer.shadowOpacity = 0.5
            //                parentview.layer.shadowRadius = 3.0
                            
                    //        //for bottom shadow on view
                    //        parentview.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
                    //        parentview.layer.shadowOpacity = 0.7
                    //        parentview.layer.shadowRadius = 1.0
                            
                    //        //for bottom and right sides shadow on view
                    //        parentview.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                    //        parentview.layer.shadowOpacity = 1
                    //        parentview.layer.shadowRadius = 1.0
                    //
                    //
                    //        //for empty shadow on view
                    //        parentview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                    //        parentview.layer.shadowOpacity = 1
                    //        parentview.layer.shadowRadius = 0
                    //
                    //        //for bottom and right and left sides shadow on view
                    //        parentview.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                    //        parentview.layer.shadowOpacity = 1
                    //        parentview.layer.shadowRadius = 2.0
                    //
                    
                    
            //                for four sides shadow on view
                           parentview.layer.shadowColor = shadowColor.cgColor

                            parentview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                            parentview.layer.shadowOpacity = 1.0
                            parentview.layer.shadowRadius = 5.0
            
          
                }
    func addBottomShadowImage(parentview:UIView, shadowColor : UIColor){
//                 ADD Shadow right &Bottom & left
                                parentview.layer.shadowColor = shadowColor.cgColor
                
                                parentview.layer.masksToBounds = false
                                parentview.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                                parentview.layer.shadowOpacity = 0.5
                                parentview.layer.shadowRadius = 3.0

            }

    
    func addFullShadowImage(parentview:UIView, shadowColor : UIColor){
                
        //       for four sides shadow on view
                
                parentview.layer.shadowColor = shadowColor.cgColor
                parentview.layer.masksToBounds = false
                parentview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                parentview.layer.shadowOpacity = 1.0
                parentview.layer.shadowRadius = 5.0
            }
    
    
    func checkBoxButton(sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        
    }
    
    
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {

            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{

        get{
            return layer.shadowOffset
        }set{

            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
}
