//
//  UiviewController.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import CDAlertView
import PKHUD
import SystemConfiguration
import MIAlertController
import UIKit

extension UIViewController {

    func connectionFailedAlert() {
        let alert = CDAlertView(title: "", message: Constants.messages.connectionFailed, type: .error)
        let doneAction = CDAlertViewAction(title: Constants.titles.done,font: UIFont.init(name: "Tajawal-Regular", size: 12))
        doneAction.buttonTextColor = .label
        alert.circleFillColor = .systemRed
        alert.add(action: doneAction)
        alert.show()
    }
   
    func showErrorAlert(message:String) {
        let alert = CDAlertView(title: "", message:message, type: .error)
        let doneAction = CDAlertViewAction(title:"حسنا",font: UIFont.init(name: "Tajawal-Regular", size: 12))
        doneAction.buttonTextColor = .label
        alert.circleFillColor = .systemRed
        alert.add(action: doneAction)
        alert.show()
    }
   
    func showSuccessAlert(message:String) {
        let alert = CDAlertView(title: "", message:message, type: .success)
        let doneAction = CDAlertViewAction(title: "حسنا",font: UIFont.init(name: "Tajawal-Regular", size: 12))
        doneAction.buttonTextColor = .label
        alert.circleFillColor = .systemGreen
        alert.add(action: doneAction)
        alert.show()
    }
    
    func showNoInternetAlert() {
        let alert = CDAlertView(title: "", message:Constants.messages.no_internet_connection, type: .error)
        let doneAction = CDAlertViewAction(title: "حسنا",font: UIFont.init(name: "Tajawal-Regular", size: 12))
        doneAction.buttonTextColor = .label
        alert.circleFillColor = .systemRed
        alert.add(action: doneAction)
        alert.show()
    }
    
    func isConnectedToInternet() -> Bool
    {
        if Reachability.isConnectedToNetwork(){
            return true
        }
        else{
            
        return false
        }
        
    }
    
    
    func checkIfNotEmpty(for textFields: [UITextField]) -> Bool {
        
        var emptyFields = [UITextField]()
        
        for textField in textFields {
            if textField.text?.isEmpty ?? true {
//                textField.borderWidth = 1
//                textField.borderColor = .systemRed
                emptyFields.append(textField)
            } else {
//                textField.borderWidth = 0
            }
        }
        
        if !(emptyFields.isEmpty) {
            HUD.flash(.label(Constants.messages.fillEmptyFields), delay: 0.5)
        }
        
        return emptyFields.isEmpty
    }
    

}
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.init(named: "#butterscotch_two")
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
