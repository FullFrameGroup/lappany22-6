//
//  VerifiCation+TfDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/11/21.
//

import Foundation
import UIKit

extension VerifyCodeVC:UITextFieldDelegate {
    
    func tFDelegate(){
        
        firstTF.delegate = self
        secondTf.delegate = self
        thirdTf.delegate = self
        fourthTf.delegate = self

        firstTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        secondTf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        thirdTf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fourthTf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
            let text = textField.text
            if  text?.count == 1 {
                switch textField{
                case firstTF:
                    secondTf.becomeFirstResponder()
                    firstTF.textColor =  UIColor.red
                    firstunderLine.backgroundColor =  UIColor.red
                    
                    
                case secondTf:
                    
                    thirdTf.becomeFirstResponder()
                    secondTf.textColor =  UIColor.red
                    secondunderLine.backgroundColor =  UIColor.red
                    
                    firstTF.textColor =  UIColor.lightGray
                    firstunderLine.backgroundColor =  UIColor.lightGray
                    
                    
                case thirdTf:
                    fourthTf.becomeFirstResponder()
                    thirdTf.textColor =  UIColor.red
                    thirdunderLine.backgroundColor =  UIColor.red
                    secondTf.textColor =  UIColor.lightGray
                    secondunderLine.backgroundColor =  UIColor.lightGray
                    
                    
                    
                case fourthTf:
                    fourthTf.becomeFirstResponder()
                    fourthTf.textColor =  UIColor.red
                    fourthunderLine.backgroundColor =  UIColor.red
                    thirdTf.textColor =  UIColor.lightGray
                    thirdunderLine.backgroundColor =  UIColor.lightGray
                default:
                    break
                }
            }
            if  text?.count == 0 {
                switch textField{
                case firstTF:
                    firstTF.becomeFirstResponder()
                    firstTF.textColor =  UIColor.red
                    firstunderLine.backgroundColor =  UIColor.red
                    
                    
                case secondTf:
                    
                    secondTf.textColor =  UIColor.lightGray
                    secondunderLine.backgroundColor =  UIColor.lightGray
                    
                    firstTF.becomeFirstResponder()
                    firstTF.textColor =  UIColor.red
                    firstunderLine.backgroundColor =  UIColor.red
                    
                case thirdTf:
                    thirdTf.textColor =  UIColor.lightGray
                    thirdunderLine.backgroundColor =  UIColor.lightGray
                    
                    secondTf.becomeFirstResponder()
                    secondTf.textColor =  UIColor.red
                    secondunderLine.backgroundColor =  UIColor.red
                case fourthTf:
                    
                    fourthTf.textColor =  UIColor.lightGray
                    fourthunderLine.backgroundColor =  UIColor.lightGray
                    
                    thirdTf.becomeFirstResponder()
                    thirdTf.textColor =  UIColor.red
                    thirdunderLine.backgroundColor =  UIColor.red
                default:
                    break
                }
            }
            else{

            }
        }
}
