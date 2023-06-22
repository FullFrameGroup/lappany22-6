//
//  MakeComplaintsVC.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import UIKit
import UIKit
import DropDown
import TransitionButton
import LSDialogViewController

class MakeComplaintsVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var btnUploadComplaint: UIButton!
    @IBOutlet var tvNotes: UITextView!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var btnTitlesType: UIButton!
    @IBOutlet var placeHolderLbl: UILabel!
    
    var delegate2:ComplaintsLitsVC?
    var complaintVM:MakeComplaintViewModel!
    
    let titleTypesMenue = DropDown()
    var titleTypesNameArray = [String]()
    var selectedTitleTypeId = -1
    var titlesTypeArr:[ComplaintTypes]?

    override func viewDidLoad() {
        super.viewDidLoad()
        btnUploadComplaint.roundedBottom(rounded: 20)
        complaintVM = MakeComplaintViewModel(delegate: self)
        callGetTypesApi()
        setUpTypesDropDown()
        tvNotes.delegate =  self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func callGetTypesApi(){
        if isConnectedToInternet(){
            complaintVM.getTypesApi()
        }else{
            showNoInternetAlert()
        }
        
    }
    
    
    @IBAction func MakeComplaintAction(_ sender: Any) {
        if isConnectedToInternet(){
            if tfName.text?.count == 0 {
                showMessage(msg: "من فضلك أدخل الإسم", type: .error)
            }else if tfPhone.text?.count == 0{
                showMessage(msg: "من فضلك أدخل رقم الهاتف", type: .error)
            }else if selectedTitleTypeId == -1 {
                showMessage(msg: "من فضلك قم بإختيار عنوان الشكوي", type: .error)

            }else
            if tvNotes.text.count == 0 {
                showMessage(msg: "من فضلك اكتب الملاحظات", type: .error)

            }else{
                
                callUploadComplaintApi()
            }
         
        }else{
          
            showNoInternetAlert()
        }

    }
    
       
   
    
 
        @IBAction func titleBtnAction(_ sender: UIButton) {
            
            titleTypesMenue.show()
        }
    
 
    @IBAction func closeAction(_ sender: UIButton) {//3
//        delegate2?.dismissDialog()
        self.dismiss(animated: true, completion: nil)
        
    }
  
    
    @IBAction func tapChooseMenuItem(_ sender: UIButton) {//3
        titleTypesMenue.show()
        
    }

    func setUpTypesDropDown()
    {
        titleTypesMenue.langNum = "1"
        titleTypesMenue.isTransform = true
        
        titleTypesMenue.anchorView = btnTitlesType //5
        titleTypesMenue.bottomOffset = CGPoint(x: 0, y: titleTypesMenue.frame.size.height) //6
        titleTypesMenue.direction  = .bottom
        titleTypesMenue.backgroundColor = .white
        titleTypesMenue.addShadow(color: .lightText)
        titleTypesMenue.layer.cornerRadius = 10
        titleTypesMenue.animationEntranceOptions = .curveEaseInOut
        
        
        titleTypesMenue.selectionAction = {  (index: Int, item: String) in
            self.btnTitlesType.setTitle(self.titleTypesNameArray[index], for: .normal)
            self.selectedTitleTypeId = self.titlesTypeArr![index].complaint_type_id!
            
            
        }
    }
    func loadTypesMenu()
    {
        var names : [String] = []
        for type in titlesTypeArr ?? []
        {
            names.append(type.title ?? "")
            
        }
        titleTypesMenue.dataSource = names
        titleTypesNameArray = names
    }
    
    func callUploadComplaintApi(){
        if isConnectedToInternet()
        {
            guard let id = AppDelegate.getUserData()?.id else{return}
            let parameters = ["user_id":id,"name":tfName.text!,"phone":tfPhone.text!,"city":selectedTitleTypeId ,"title":selectedTitleTypeId,"description":tvNotes.text!] as [String : Any]
           
            complaintVM.uploadComplaintsApi(parameters: parameters)

        }else{
            self.showNoInternetAlert()
        }
    }
    
    
    


}
