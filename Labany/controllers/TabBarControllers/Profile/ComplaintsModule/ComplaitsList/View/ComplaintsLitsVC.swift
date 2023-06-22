//
//  ComplaintsLitsVC.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import UIKit
import Presentr


class ComplaintsLitsVC: BaseVC {
    

    @IBOutlet weak var complaintsTable: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet var lblnoComplaints: UILabel!
    var complaintsVM:ComplaintsLitsViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        lblnoComplaints.isHidden = true
        complaintsVM = ComplaintsLitsViewModel(delegate:self)
        headerView.delegate = self
        headerView.lblTitle.text = "الشكاوي"
        setupTableView()
        // Observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.ReloadComplaintsList),
            name: NSNotification.Name(rawValue: "reloadComplaintsList"),
            object: nil)
        
        // callApi
        let userId = AppDelegate.getUserData()?.id

            self.callApi(user_id:userId ?? 0)
        
    }
    
  
    
    
    
    @IBAction func openUploadComplaintAction(_ sender: Any){
        OpenMAkeComplaintVC()
    }
    
    func callApi(user_id:Int){
        
        if isConnectedToInternet()
        {
            complaintsVM.getUserComplaintsApi(user_id:user_id)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    // OpenUpload Complaints Dialog
    func OpenMAkeComplaintVC(){
        let VC = MakeComplaintsVC()
        let presenter = Presentr(presentationType: .custom(width: .custom(size: Float(self.view.bounds.width - 20)), height: .custom(size: Float(self.view.bounds.height)), center: .center) )
        customPresentViewController(presenter, viewController: VC, animated: false, completion: nil)

    }
    
    func dismissDialog() {
       // dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }
    
    
    
    // Notification Reload Datat After Add complaints
    
    @objc func ReloadComplaintsList(){
        let userId = AppDelegate.getUserData()?.id
        self.callApi(user_id:userId ?? 0)
        
    }
  

    
}
extension ComplaintsLitsVC : HeaderDelegate {

    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    



    }
    
    
    
    


extension UIView {

    
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}


