//
//  AppConstants.swift
//  EkratFozan
//
//  Created by Eman Gaberr on 11/17/18.
//  Copyright © 2018 Eman Gaberr. All rights reserved.
//

import Foundation
import UIKit

import MIAlertController
//
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let mainColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
let greyColor = #colorLiteral(red: 0.961928308, green: 0.9620661139, blue: 0.9618980289, alpha: 1)
let brownColor = #colorLiteral(red: 0.961928308, green: 0.9620661139, blue: 0.9618980289, alpha: 1)
let shadowColor = #colorLiteral(red: 0.961928308, green: 0.9620661139, blue: 0.9618980289, alpha: 1)


import UIKit


struct Constants {
    static let isArabic = false
//    static let images = Images()
//    static let nibName = NibName()
    static let messages = Messages()
    static let titles = Titles()
//    static let homeCellTitles = HomeCellTitles()
//    static let programTabsTitles = ProgramTabsTitles()
//    static let address = AddressComponents()
    
}

struct Titles {
    var done: String {return "ok".localized }
    var yes: String {return "yes".localized }
    var no: String {return "no".localized }
//    var myAddresses: String { return NSLocalizedString("My Addresses", comment: "")}
//    var pay: String { return NSLocalizedString("Pay", comment: "")}
//    var confirm: String { return NSLocalizedString("Confirm", comment: "")}
}
struct Messages {
    var connectionFailed: String {return "Connection_Failed".localized }
    
    var no_internet_connection: String {return "no_internet_connection".localized }
    
//    var currency: String {return "KD".localized}
//    var selectCity: String {return NSLocalizedString("Select City", comment: "") }
//    var from: String {return NSLocalizedString("from", comment: "") }
//    var to: String {return NSLocalizedString("to", comment: "") }
    var fillEmptyFields: String {return "من فضل أدخل بياناتك".localized}
//    var selectTime: String { return NSLocalizedString("Select time", comment: "")}
//    var selectContactMethod: String { return NSLocalizedString("Select contact method", comment: "")}
//    var enterEventTitle: String { return NSLocalizedString("Enter event title", comment: "")}
//    var noOrderId: String { return NSLocalizedString("Can't find order id", comment: "")}
}



extension NSString
{
    func isMaxmiumString(maxLength :Int, range :NSRange,string :String) -> Bool
    {
        let currentString: NSString = self
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func isMinimumString(minLength :Int, range :NSRange,string :String) -> Bool
    {
        let currentString: NSString = self
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= minLength
    }
}


