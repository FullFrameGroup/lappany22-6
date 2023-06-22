//
//  ComplaintsLitsViewModel+Delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation

extension ComplaintsLitsVC :ComplaintsLitsViewModelDelegate{
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func GetUserComplaintsSuccessfully(complaints: [ComplaitsList]) {

        if complaints.count == 0
        {
            complaintsTable.setEmptyMessage("لا توجد شكاوي")

        }else{
            complaintsTable.restore()

            self.complaintsTable.reloadData()
            self.complaintsTable.showLoader()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
                self.lblnoComplaints.isHidden = true
        
        }
    }

    func showErrorAlert(error:String){
        lblnoComplaints.isHidden = false
        
    }
  
    @objc func removeLoader()
    {
        self.complaintsTable.hideLoader()
    }
   


}
