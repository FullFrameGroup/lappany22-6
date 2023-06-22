//
//  Loader.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 2/27/21.
//

import Foundation
import UIKit
import TransitionButton

protocol loaderDelegate {
    func cancelTrip()
}

class loader: NSObject {
    static let shared = loader()
    var tripId: Int?
    var delegate: loaderDelegate?
    
    
    func showLoader(view: UIView, loaderColor: UIColor = UIColor(named: "DarkPurple") ?? .black, withOverlay: Bool = false, alpha: CGFloat = 0.9, loadingMsg: String? = nil,cancelMsg: String? = nil,tripId: Int? = nil, largeLoader: Bool = true, delegate:loaderDelegate? = nil) {
        self.delegate = delegate
        self.tripId = tripId
        
        if withOverlay {
            let overLayView = UIView(frame: view.bounds)
            overLayView.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            overLayView.tag = 8709
            
            let activityIndicator = UIActivityIndicatorView(style: largeLoader ? .whiteLarge : .white)
            activityIndicator.color = loaderColor
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//            activityIndicator.center = overLayView.center
            activityIndicator.tag = 4994
            overLayView.addSubview(activityIndicator)
            let activityConstrains = [
                              activityIndicator.centerXAnchor.constraint(equalTo: overLayView.centerXAnchor, constant: 0),
                              activityIndicator.centerYAnchor.constraint(equalTo: overLayView.centerYAnchor)
            ]
            NSLayoutConstraint.activate(activityConstrains)
            
            if let loadingMsg = loadingMsg {
                let msgLabel = UILabel()
                msgLabel.translatesAutoresizingMaskIntoConstraints = false
                msgLabel.textAlignment = .center
                msgLabel.font = UIFont(name:  "SFProDisplay-Regular", size: 14.0)
                msgLabel.numberOfLines = 2
                msgLabel.text = loadingMsg
                msgLabel.textColor = loaderColor
                overLayView.addSubview(msgLabel)
                let constrains = [msgLabel.heightAnchor.constraint(equalToConstant: 20),
                                  msgLabel.bottomAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: -20),
                                  msgLabel.centerXAnchor.constraint(equalTo: overLayView.centerXAnchor, constant: -50),
                                  msgLabel.leadingAnchor.constraint(equalTo: overLayView.leadingAnchor, constant: 5),
                                  msgLabel.trailingAnchor.constraint(equalTo: overLayView.trailingAnchor, constant: -5)
                ]
                NSLayoutConstraint.activate(constrains)
            }
            
            if let cancelMsg = cancelMsg {
                let cancelButton = TransitionButton()
                cancelButton.translatesAutoresizingMaskIntoConstraints = false
                cancelButton.contentHorizontalAlignment = .center
//                cancelButton.font = UIFont(name:  "SFProDisplay-Regular", size: 14.0)
                cancelButton.layer.cornerRadius = 15
                cancelButton.clipsToBounds = true
//                cancelButton.addTarget(self, action: #selector(cancelTripAction), for: .touchUpInside)
                cancelButton.setTitle(cancelMsg, for: .normal)
                cancelButton.setTitleColor(.white, for: .normal)
                cancelButton.backgroundColor = .black
                overLayView.addSubview(cancelButton)
                let constrains = [cancelButton.heightAnchor.constraint(equalToConstant: 35),
                                  cancelButton.widthAnchor.constraint(equalToConstant: 150),
                                  cancelButton.bottomAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: 110),
                                  cancelButton.centerXAnchor.constraint(equalTo: overLayView.centerXAnchor, constant: 0),
//                                  cancelButton.leadingAnchor.constraint(equalTo: overLayView.leadingAnchor, constant: 5),
//                                  cancelButton.trailingAnchor.constraint(equalTo: overLayView.trailingAnchor, constant: -5)
                ]
                NSLayoutConstraint.activate(constrains)
            }
            
            view.addSubview(overLayView)
            activityIndicator.startAnimating()
            
            
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = loaderColor
            activityIndicator.center = view.center
            activityIndicator.tag = 4994
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            let activityConstrains = [
                              activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                              activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
            NSLayoutConstraint.activate(activityConstrains)
            
        }
    }

    
    
    
    func hideLoader(view: UIView, withOverlay: Bool = false) {
        if withOverlay {
            if let overlayView = view.viewWithTag(8709) {
                overlayView.removeFromSuperview()
            }
        } else {
            if let activityIndicator = view.viewWithTag(4994) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    
}
