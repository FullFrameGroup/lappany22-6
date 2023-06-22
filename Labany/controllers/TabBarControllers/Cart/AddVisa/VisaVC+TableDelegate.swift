//
//  VisaVC+TableDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 8/3/21.
//

import Foundation
import UIKit
import AnimatableReload
import FSCalendar

extension VisaVC :UITableViewDelegate , UITableViewDataSource {
    
    func setupTableView()
    {
        viseTable.delegate = self
        viseTable.dataSource = self
        viseTable.register(UINib.init(nibName: "VisaCardCell", bundle:nil), forCellReuseIdentifier: "cell")
        
        AnimatableReload.reload(tableView: viseTable, animationDirection: "down")
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VisaVM.visaArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let Item = VisaVM.visaArr?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VisaCardCell
        cell.Configure(visa: Item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    

//        pay(amount:Double,currency:String)
        let Item = VisaVM.visaArr?[indexPath.row]
       let itemAmount = self.itemAmount
          
        let name = Item?.card_holder_name
        let cardNum = Item?.card_number
        let cardCvv = Item?.secret_code
        let cardExp = Item?.cart_date
        var cardDate = "2022-03-27"

        let dateString = cardDate
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
          // guard
            let date = formatter.date(from: dateString)
        
        //else {
//               return
//           }
           formatter.dateFormat = "yyyy"
           let year = formatter.string(from: date!)
           formatter.dateFormat = "MM"
           let month = formatter.string(from: date!)
           formatter.dateFormat = "dd"
           let day = formatter.string(from: date!)
        

        
        NotificationCenter.default.post(name: Notification.Name("callRequestCheckoutIDAPi"),object: nil,userInfo:nil)

 

        self.dismiss(animated: true, completion:nil)
        
    }
    

    
    
    
  
    
}





extension DateFormatter {

    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {

    func toDate (dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }

    func toDateString (dateFormatter: DateFormatter, outputFormat: String) -> String? {
        guard let date = toDate(dateFormatter: dateFormatter) else { return nil }
        return DateFormatter(format: outputFormat).string(from: date)
    }
}

extension Date {

    func toString (dateFormatter: DateFormatter) -> String? {
        return dateFormatter.string(from: self)
    }
}
