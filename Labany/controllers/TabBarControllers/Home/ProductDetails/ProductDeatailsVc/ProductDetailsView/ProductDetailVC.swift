//
//  ProductDetailVC.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import UIKit
import UIKit
import DropDown
import TransitionButton
import LSDialogViewController
import PKHUD


class ProductDetailVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet var lblnumber: UILabel!
    @IBOutlet var finalPrice: UILabel!
   
    @IBOutlet var tfNotes: UITextView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var btnCuttinng: UIButton!
    @IBOutlet var btnSize: UIButton!
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var btnPackaging: UIButton!
    @IBOutlet var btnAddToCart: UIButton!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var btnExtra: UIButton!
    @IBOutlet var placeHolderLbl: UILabel!
    
    var total:Int?
    var productDetailVM:ProductDetailViewModel!
    var productID:Int?
    var productName:String?
    var delegate:HomeVC?
   
    let extraMenue = DropDown()
    let cuttingMenue = DropDown()
    let sizeMenue = DropDown()
    let packagingMenue = DropDown()
    
    var cuttNamesArray = [String]()
    var selectedCuttId = -1
    
    var extraNamesArray = [String]()
    var selectedExtraId =  -1
    
    var packageNamesArray = [String]()
    var selectedPackageId = -1
    
    var sizeNamesArray = [String]()
    var selectedSizeId = -1
    var quantity = 1
    
    var extraArr:[ExtraModel]?
    var packageArr:[PackingModel]?
    var sizeArr:[SizeModel]?
    var cuttArr:[CutModel]?
    
    var packagingPrice:Double?
    var extraPrice :Double?
    var sizePrice :Double?
    var cutPrice :Double?
    var productTypeId:Int?
    var img : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNotes.delegate = self
        productDetailVM = ProductDetailViewModel(delegate: self)

      
            extraMenue.langNum = "1"
            extraMenue.isTransform = true
            
            sizeMenue.langNum = "1"
            sizeMenue.isTransform = true
            
            cuttingMenue.langNum = "1"
            cuttingMenue.isTransform = true
            
            packagingMenue.langNum = "1"
            packagingMenue.isTransform = true
        
        
        setUpCuttingDropDown()
        setUpSizeDropDown()
        setUpExtreDropDown()
        setUpPackagingDropDown()
        
        // adjust height and width of dialog
        view.bounds.size.height = (UIScreen.main.bounds.size.height * 0.8)  - 200
        view.bounds.size.width = UIScreen.main.bounds.size.width * 0.8
        view.layer.cornerRadius = 20
        btnAddToCart.roundedBottom(rounded: 20)
        bottomView.roundedBottom(rounded: 20)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let cityId = UserDefaults.standard.value(forKey: "city_id")
        {
            productDetailVM.getProductDetailsApi(cityId: cityId as! Int, productId:productID!)
        }
        else
        {
            productDetailVM.getProductDetailsApi(cityId: 1, productId:productID!)
        }
        lblProductName.text = productName
        
        setUpCuttingDropDown()
        setUpSizeDropDown()
        setUpExtreDropDown()
        setUpPackagingDropDown()
        refreshtotal()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        if selectedCuttId == -1 && cuttArr?.count != 0
        {
            showMessage(msg: "اختر نوع التقطيع", type: .notification)
        }else
          if  selectedSizeId == -1 && sizeArr?.count != 0
        {
            showMessage(msg: "اختر الحجم", type: .notification)

        }else  if selectedPackageId == -1 && packageArr?.count  != 0
        {
            showMessage(msg: "اختر نوع التغليف", type: .notification)
        
        }else if UserDefaults.standard.isLoggedIn() {
           callAddToCart()
        }else{
            showLoginAlert()
        }
        
    }
    
    @IBAction func extraBtAction(_ sender: UIButton) {
        extraMenue.show()
    }
    
    @IBAction func packageBtAction(_ sender: UIButton) {
        packagingMenue.show()
    }
        @IBAction func cuttingBtnAction(_ sender: UIButton) {
            
            cuttingMenue.show()
        }
    
    @IBAction func sizeBtnAction(_ sender: UIButton) {
        
        sizeMenue.show()
    }

    @IBAction func closeButton(_ sender: AnyObject) {
        
    }
    
    
    @IBAction func plusTapped(_ sender:UIButton){
        quantity = quantity + 1
        lblnumber.text = "\(quantity)"
        
        let Price = ( Double(quantity) * Double(sizePrice ?? 0))
        
    lblPrice.text = "\(Double(Price))"
        self.refreshtotal()
    }
    
    @IBAction func minusTapped(_ sender:UIButton){
       
        if quantity > 1
        {
            quantity = quantity - 1
            lblnumber.text = "\(quantity)"
            let Price = ( Double(quantity) * Double(sizePrice ?? 0))
            lblPrice.text = "\(Double(Price))"
            self.refreshtotal()
            
        }
    }
    
    
//MARK:------ Add action
    func callAddToCart(){
        guard let id = AppDelegate.getUserData()?.id else{return}
        var parameters = ["pid":productID as Any,
                          "qty":quantity,
                          "sizeId" : selectedSizeId,
                          "sizePrice": sizePrice as Any,
                          "notes":tfNotes.text ?? "",
                          "productType":productTypeId as Any] as [String : Any]
        
        if selectedPackageId != -1
        {
            parameters["packingId"] = selectedPackageId
            parameters["packingPrice"] = packagingPrice
        }
        
        if selectedCuttId != -1
        {
            parameters["cutId"] = selectedCuttId
            parameters["cutPrice"] = cutPrice
        }
        
        if selectedExtraId != -1
        {
            parameters["extraPrice"] = extraPrice
            parameters["extraId"] = selectedExtraId
        }

            productDetailVM.callAddToCartApi(parameters: parameters, user_id: id)

        
    }

    
    
    func setUpCuttingDropDown()
    {
        cuttingMenue.anchorView = btnCuttinng //5
        cuttingMenue.bottomOffset = CGPoint(x: 0, y: cuttingMenue.frame.size.height) //6
        cuttingMenue.direction  = .bottom
        cuttingMenue.backgroundColor = .white
        cuttingMenue.addShadow(color: .lightText)
        cuttingMenue.layer.cornerRadius = 10
        cuttingMenue.animationEntranceOptions = .transitionCurlUp
        cuttingMenue.selectionAction = {  (index: Int, item: String) in
        self.btnCuttinng.setTitle(self.cuttNamesArray[index], for: .normal)
            self.btnCuttinng.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.selectedCuttId = self.cuttArr![index].cut_piece_id!
            self.cutPrice = self.cuttArr![index].cut_piece_price
            self.refreshtotal()
            
            }
    }
    
    func refreshtotal(){
        
        let total  = Double(cutPrice ?? 0) + Double(sizePrice ?? 0) + Double(packagingPrice ?? 0) + Double(extraPrice ?? 0)
      
        let fial = ( Double(quantity) * Double(total))
        finalPrice.text = "\(Double(fial)) ريال"
    }

    
    func setUpSizeDropDown()
    {
        sizeMenue.anchorView = btnCuttinng
        sizeMenue.bottomOffset = CGPoint(x: 0, y: btnSize.frame.size.height) //6
        sizeMenue.direction  = .bottom
        sizeMenue.backgroundColor = .white
        sizeMenue.addShadow(color: .lightText)
        sizeMenue.layer.cornerRadius = 10
        sizeMenue.animationEntranceOptions = .curveEaseInOut

        sizeMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.btnSize.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self?.btnSize.setTitle(item, for: .normal)
            self!.sizePrice = self?.sizeArr![index].size_price
            self!.selectedSizeId = (self?.sizeArr![index].size_id)!

            let x = Double(self!.lblnumber.text!)
            
            self?.lblPrice.text =  "\(Double((self?.sizeArr![index].size_price)!) * x!)"
            self?.refreshtotal()
        }
    }
    

    func setUpExtreDropDown()
    {
        extraMenue.anchorView = btnExtra
        extraMenue.bottomOffset = CGPoint(x: 0, y: btnExtra.frame.size.height) //6
        extraMenue.direction  = .bottom
        extraMenue.backgroundColor = .white
        extraMenue.addShadow(color: .lightText)
        extraMenue.layer.cornerRadius = 10
        extraMenue.animationEntranceOptions = .curveEaseOut

        extraMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.btnExtra.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)

            self?.btnExtra.setTitle(item, for: .normal)
            self?.extraPrice = self?.extraArr![index].extra_price
            self?.selectedExtraId = (self?.extraArr![index].extra_id)!
            self?.refreshtotal()
        }
    }

    func setUpPackagingDropDown()
    {
        packagingMenue.anchorView = btnPackaging
        packagingMenue.bottomOffset = CGPoint(x: 0, y: btnPackaging.frame.size.height) //6
        packagingMenue.direction  = .bottom
        packagingMenue.backgroundColor = .white
        packagingMenue.addShadow(color: .lightText)
        btnPackaging.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        packagingMenue.layer.cornerRadius = 10
        packagingMenue.animationEntranceOptions = .beginFromCurrentState

        packagingMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.btnPackaging.setTitle(item, for: .normal)

            self?.btnPackaging.setTitle(item, for: .normal)
            self?.packagingPrice = self?.packageArr![index].packing_price
            self?.selectedPackageId = (self?.packageArr![index].packing_id)!

            self?.refreshtotal()

        }
    }
    
 
    
    func loadExtraMenu()
    {
        var names : [String] = []
        for extra in extraArr ?? []
        {
            names.append(extra.extra_type ?? "")

        }
        extraMenue.dataSource = names
        extraNamesArray = names
    }
    
    func loadCuttMenu()
    {
        var names : [String] = []
        for cutt in cuttArr ?? []
        {
            names.append(cutt.cut_piece_type ?? "")
            
        }
        cuttingMenue.dataSource = names
        cuttNamesArray = names
    }
    
    func loadSizeMenu()
    {
        var names : [String] = []
        for size in sizeArr ?? []
        {
            names.append(size.size_type ?? "")

        }
        sizeMenue.dataSource = names
        sizeNamesArray = names
    }


    func loadPackagingMenu()
    {
        var names : [String] = []
        for package in packageArr ?? []
        {
            names.append(package.packing_type ?? "")

        }
        packagingMenue.dataSource = names
        packageNamesArray = names
    }

}
