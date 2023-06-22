//
//  RateOrderVC.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import UIKit

class RateOrderVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var rateTable:UITableView!
    @IBOutlet weak var tvNote:UITextView!
    @IBOutlet weak var placeHolderLbl:UILabel!
    @IBOutlet weak var btnSend:UIButton!

    var rateVCDelegate:MyOrdersListVC?
    var rateOrderVM:RateOrderViewModel!
    
    var answersArray:[questions] = []
    var orderId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvNote.delegate = self
        rateOrderVM = RateOrderViewModel(delegate: self)
    
        btnSend.roundedBottom(rounded: 20)
        
        let userID = AppDelegate.getUserData()?.id
        rateOrderVM.getQuestionnsApi(user_id: userID!)
        setupTableView()
        view.bounds.size.height = (UIScreen.main.bounds.size.height * 0.5)  - 60
        view.bounds.size.width = UIScreen.main.bounds.size.width * 0.8
        view.layer.cornerRadius = 20
    }
    
    
     func textViewDidBeginEditing(_ textView: UITextView) {
         self.placeHolderLbl.isHidden = true
     }

     func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text.isEmpty {
             self.placeHolderLbl.isHidden = false
         } else {
             self.placeHolderLbl.isHidden = true
         }
     }

    @IBAction func saveRate(_ sender :Any){
        if answersArray.count != rateOrderVM.qusArr?.count
        {
            showMessage(msg: "من فضلك اجب عن جميع الأسئلة", type: .error)

        }else{
            if isConnectedToInternet() {
                guard let userId = AppDelegate.getUserData()?.id else{return}
                var itemsStr = ""
                
                
                for item in answersArray
                {
                    
                    itemsStr.append("{\"question_id\":\(item.id!),\"answer\":\(item.title!)}&")
                }
                
                let newStr = itemsStr.dropLast()
           

                
                let parameters = ["user_id":userId,
                                  "order_id":orderId,
                                  "comment":"ssss",
                                  "questions":newStr] as [String : Any]

        rateOrderVM.saveRateApi(parameters: parameters)
            }else {
                showNoInternetAlert()

            }
        }
        }
        
    @IBAction func cloaseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    }
    
  
