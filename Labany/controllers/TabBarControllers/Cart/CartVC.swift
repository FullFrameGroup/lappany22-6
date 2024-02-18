//
//  CartVC.swift
//  Labany
//
//  Created by Eman Gaber on 6/30/21.
//

import UIKit
import Presentr
import CDAlertView
import DropDown
import SafariServices
import PKHUD

//import GeideaPaymentSDK

class CartVC: BaseVC{
  
    
    var safariVC: SFSafariViewController?
    var paymentHandler: OnlinePaymentHandler?

    var quantity = 1
    var cash:Bool?
    @IBOutlet var viewEmptyCart: UIView!
    @IBOutlet var btnAddCopon: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headrView: HeaderView!
    
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet var datepickerr: UIDatePicker!
    //@IBOutlet var btnMakeOrder: UIButton!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var viewScrrollHeight: NSLayoutConstraint!
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet var tfWalletAmount: UITextField!
    @IBOutlet weak var visaCollection: UICollectionView!
    @IBOutlet var lblWalletAmoumt: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTotalBeforDiscount: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var tfCoupon: UITextField!
    @IBOutlet var switchWalletAmount : UISwitch!
    @IBOutlet var tfOpenDatePicker: UITextField!
    @IBOutlet var btnTime: UIButton!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var btnCash: UIButton!
    @IBOutlet var btnMakeOrderrCash: UIButton!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblPaymenntType: UILabel!
    @IBOutlet weak var dateViewHeight: NSLayoutConstraint!
    
    var cartArr:[CartItemsModel]?
    var cartObjc:CartModel?
    var cartVM : CartViewModel!
    var selectAddress = ""
    var selectedLong = ""
    var selectedLat = ""
    var shippingId = 1
    var orderPriceBeforDis:Double?
    var orderPriceAfterDis:Double?
    var coponType :String?
    var coponminamount :Int?
    var coupon_id :Int?
    var amount:Int?
    var isAmount:Bool?
    var orderPrice:Double?
    var taxOnOrder:Double?
    var totalCaluctPrice:Double?
    var perrcentage:Int?
    var discount :Double?
    var selectedDate = ""
    var selectedTime = ""
    var selectedDateForApi:String?
    var selectedTimeForApi:String?
    var visaType = 0
    var paymentType:String?
    let timeMenue = DropDown()
    var timeNameArray = [String]()
    var selectedTimeId = -1
    var titleTimesArr:[TimesOpen]?
    var timeString = ""
    var timeNow = ""
    var selected = ""
    var selectCash = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.getAddress() != "" {
            lblAddress.text = UserDefaults.standard.getAddress()
            selectAddress  = UserDefaults.standard.getAddress()
        }
        btnMakeOrderrCash.backgroundColor = .lightGray
        do {
//            if #available(iOS 13.4, *) {
//                datepickerr.preferredDatePickerStyle =  .compact
//            } else {
//                // Fallback on earlier versions
//                datepickerr.preferredDatePickerStyle = .automatic
//            }
            datepickerr.datePickerMode = .date
            datepickerr.backgroundColor = .clear
            let loc = Locale(identifier: "ar")
            datepickerr.locale = loc
            
            cartVM = CartViewModel(delegate: self)
            
            timeMenue.langNum = "1"
            timeMenue.isTransform = true
            
            
            btnAddCopon.layer.cornerRadius = 5
            btnAddCopon.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
            
            tfCoupon.layer.cornerRadius = 5
            tfCoupon.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            tfCoupon.clipsToBounds = true
            
            switchWalletAmount.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
            tfWalletAmount.delegate = self
            headrView.delegate = self
            headrView.lblTitle.text = "السلة"
            
            setupTableView()
            setCollection()
            
            callGetCartApi()
            
            setUpTimesDropDown()
            
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.SetSelectedAddressAction),
                name: NSNotification.Name(rawValue: "selectCartToAddress"),
                object: nil)
            
            NotificationCenter.default.addObserver(
                self,selector: #selector(self.openAddNewVisa),
                name: NSNotification.Name(rawValue: "openAddVisa"),
                object: nil)
            
            NotificationCenter.default.addObserver(
                self,selector: #selector(self.sendID),
                name: NSNotification.Name(rawValue: "visaTypeID"),
                object: nil)
            
            NotificationCenter.default.addObserver(
                self,selector: #selector(self.openVisa),
                name: NSNotification.Name(rawValue: "openVisaVC"),
                object: nil)
            
            NotificationCenter.default.addObserver(
                self,selector: #selector(self.callMakeOrderAPi),
                name: NSNotification.Name(rawValue: "callMakeOrderAPi"),
                object: nil)
            nowDate()
            
            
        }
        catch let  error as NSError  {
            print("Error: \(error.localizedDescription)")
            cartVM.catchErrorsApi(code:123,platformtype:"ios",message:"\(error.localizedDescription)")
        }
        
        visaCollection.semanticContentAttribute = .forceRightToLeft

    }
    
 
    //MARK:- DropDown Times ------------------------------

    
    func nowDate(){
        let date = Date()
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.init(identifier: "en")
            let time = dateFormatter.string(from: date)
       
        let dateAsString = "\(time)"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "h:mm a"

        let time1 = dateFormat.date(from: dateAsString)
        dateFormat.dateFormat = "HH:mm"
        guard let time1 else{return}
        let Date24 = dateFormat.string(from: time1)
        print("24 hour formatted Date:",Date24)

       timeNow = Date24
            
     }
    
    
    @IBAction func tapChooseMenuItem(_ sender: UIButton) {//3
        cartVM.getTimeAvailable(dateslected:"\(selected)")
        timeMenue.show()
        
    }
    
    @IBAction func titleBtnAction(_ sender: UIButton) {
        if titleTimesArr?.count == 0 {
            showMessage(msg: "لا توجد أوقات متاحه من فضلك قم بختيار يوم آخر", type: .notification)
        }else if selected == "" {
            showMessage(msg: "قم بإختيار اليوم أولاً", type: .notification)
        }else{
            
            cartVM.getTimeAvailable(dateslected: selected )
            timeMenue.show()

        }
    }


    func setUpTimesDropDown()
    {
        timeMenue.anchorView = btnTime //5
        timeMenue.bottomOffset = CGPoint(x: 0, y: timeMenue.frame.size.height) //6
        timeMenue.direction  = .bottom
        timeMenue.backgroundColor = .butterscotch
        timeMenue.addShadow(color: .lightText)
        timeMenue.layer.cornerRadius = 10
        timeMenue.animationEntranceOptions = .curveEaseInOut
        
        timeMenue.selectionAction = { [self]  (index: Int, item: String) in
//            self.btnTime.setTitle("وقت التوصيل" + self.timeNameArray[index], for: .normal)
            self.lblTime.text = "\("وقت التوصيل" + self.timeNameArray[index])"
            self.selectedTimeId = self.titleTimesArr![index].id!
           
            let myFrom = self.timeNameArray[index]
            let myTime = self.timeNameArray[index]

            let myF = myFrom.replacingOccurrences(of: "مساءً", with: "")
           
            let myTo = myTime.replacingOccurrences(of: "صباحاً", with: "")

            self.timeString = "\("\(myF)" + "|" +  "\(myTo)")"
            self.selectedTime = self.timeString
            }
    }
    
    func loadTimesMenu()
    {
        var names : [String] = []
        var namesfrom : [String] = []
        var namesTo : [String] = []
        
        for time in titleTimesArr ?? []
        {
            namesfrom.append(time.from_time ?? "")
            namesTo.append(time.to_time ?? ""  )
            names.append(  " من " + time.from_time! +  " إلي " + time.to_time! )
        }
        timeMenue.dataSource = names
        timeNameArray = names
    
        
    }
      
    @IBAction func selectAddressAction(_ sender: Any) {
        
        openMapAction()
    }
    
    func openMapAction(){
        let vc = AppStoryboard.Profile.viewController(viewControllerClass: AddressListVc.self)
        vc.fromCart = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }

   
    @objc func openAddNewVisa()
    {
        perform(#selector(openAddNewVisaVC), with: nil, afterDelay: 0)

    }
    
    @objc func openVisa()
    {
        perform(#selector(openVisaVC), with: nil, afterDelay: 0)

    }
    
    @objc func sendID(notification: NSNotification)
    {
        self.visaType = (notification.userInfo!["visaTypeID"] as! Int)
        print(self.visaType)
    }
    

    @objc func openAddNewVisaVC(notification: NSNotification)
    {
        let vc = NewVisaVC()
        vc.visaTypeID = visaType
        vc.modalPresentationStyle = .automatic

        self.present(vc, animated: false, completion: nil)
    }
    
    @objc func openVisaVC(notification: NSNotification)
    {
       // requestCheckoutID()

//        let vc = VisaVC()
//        vc.visaTypeID = visaType
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: false, completion: nil)
    }
    

    @objc func switchStateDidChange(_ sender:UISwitch!)
       {
           if (sender.isOn == true){
            tfWalletAmount.isHidden = false
           }
           else{
            tfWalletAmount.isHidden = true

           }
       }
  
    
    @objc func callMakeOrderAPi(notification: NSNotification)
       {
           self.paymentType = (notification.userInfo!["paymet_type"] as! String)
           print(self.paymentType)
           addPayment(paymetType: paymentType ?? "", data: notification.userInfo?["data"] as! ResponseClass, checkoutId: notification.userInfo?["checkout_id"] as! String)
           MakeOrder(paymetType: paymentType ?? "")
       }
    @IBAction func dateAction(_ sender: UIDatePicker) {

        let formatter = DateFormatter()
        formatter.dateFormat = "d-M-yyyy"
        formatter.locale = Locale.init(identifier: "en")
        let date = formatter.string(from: datepickerr.date)
        let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.init(identifier: "en")
            let time = dateFormatter.string(from: datepickerr.date)
        print(date)
        print(time)
        selectedDate = date
       // selectedTime = time

        let formatter2 = DateFormatter()
        formatter2.dateFormat = "d-M-yyyy"
        let date2 = formatter2.string(from: datepickerr.date)
        selectedDateForApi = date2
        
        let dateFormatter2 = DateFormatter()
            dateFormatter2.timeStyle = DateFormatter.Style.short
            dateFormatter2.timeZone = TimeZone.current
            let time2 = dateFormatter2.string(from: datepickerr.date)
        selectedTimeForApi = String(time2.dropLast(3))
        
        let now = Date()
        let dateNow = formatter.string(from: now)

        print(dateNow)
        
        print(date)
        let avaliableDayes:Int = cartVM.cartData?.date_setting?.avaliable_days ?? 0
        let calendar = Calendar.autoupdatingCurrent

        let addDayesDate = calendar.date(byAdding: .day, value: avaliableDayes, to: Date())
        let endDate:String = "\(addDayesDate!)"
       let x = endDate.prefix(10)
        print(endDate.prefix(10))
     
          //  showMessage(msg: "تم إختيار تاريخ التوصيل" + "\(date)", type: .error)
        
            presentedViewController?.dismiss(animated: true, completion: nil)
            self.lblDate.text = "التاريخ " + "\(date)  "
        selected = "\(selectedDate)\(timeNow)"
        cartVM.getTimeAvailable(dateslected:"\(selected)")

    }
    
   
    
    @IBAction func addCoponAction(_ sender: Any) {
        if tfCoupon.text == ""{
            showErrorAlert(message: "من فضلك أدخل كود القسيمة")
        }else {
            
        let userID = AppDelegate.getUserData()?.id
            
         let cityID = AppDelegate.getUserData()?.city_id
        callCoponeApi(user_id:userID!,coupon_code:tfCoupon.text! ,city_id:cityID ?? 1)
            
        }

    }

    
    func callCoponeApi(user_id:Int,coupon_code:String ,city_id:Int){
        if isConnectedToInternet() {
            let parameters = ["user_id":user_id,"coupon_code":coupon_code,"city_id":city_id] as [String : Any]
            
            cartVM.callCheckCouponApi(parameters:parameters )
        }else
        {
            showNoInternetAlert()
        }
    }
    
    func updateCartItem(cartItem:CartItemsModel, index:Int)
    {
        cartVM.cartItemsArr?[index] = cartItem
        calculateTotalPriceForAllItems()
       
    }
    
    func  calculateTotalPriceForAllItems()
    {
        var total = 0
        for item in cartVM.cartItemsArr ?? []
        {
            total += item.total_price ?? 0
        }
        
        if cartVM.couponDetail != nil {
            checkCoponWithTotalPrice()
        }else
        {
            let shippingPrice =  Double(cartVM.cartData?.shipping ?? 0)
            
            //الضريبة علي المنتج قبل خصمamount
            let tax = Double(cartVM.cartData?.tax ?? 0)
            taxOnOrder = (tax*Double(total))/100
            
            totalCaluctPrice = Double(total) + shippingPrice + taxOnOrder!
            lblTotal.text = "\(totalCaluctPrice ?? 0) " + "ريال"
            lblTotalBeforDiscount.text = "\(totalCaluctPrice ?? 0) " + "ريال"
            
        }
    }
    
    //MARK: MAke order action --------
    @IBAction func cashPaymentAction(_ sender :UIButton){
        selectCash = 1
        cash = true
        btnMakeOrderrCash.backgroundColor  = UIColor.init(named: "#dull_red")
    }

    @IBAction func cashMakeOrderAction(_ sender :UIButton){
        
         if selectCash == 0 {
             showMessage(msg: "اختر طريقة الدفع كاش أولاً", type: .error)
         }else{
             MakeOrder(paymetType:"CASH")
         }
    }
    
    
    
   // call when payment success
    func checkForError()->Bool{
        if selectAddress.isEmpty{
         showMessage(msg: "اختر عنوان التوصيل", type: .notification)
            return false
        }else if selectedDate.isEmpty
        {
         showMessage(msg: "اختر تاريخ التوصيل", type: .notification)
            return false
        }else if selectedTime.isEmpty{
            showMessage(msg: "اختر ووقت التوصيل", type: .notification)
            return false
        }else{
            return true
        }
    }
    func addPayment(paymetType:String,data:ResponseClass,checkoutId:String){
        guard let userId = AppDelegate.getUserData()?.id else{return}
        let parameters = [    "user_id":userId,
                              "card_amt":totalCaluctPrice ?? 0,
                              "transaction_id":data.id,
                              "checkoutId":checkoutId,
                              "payment_info":data.paymentBrand,
                              "card_number": data.card.last4Digits,
                              "card_holdername":data.card.holder,
                              "card_expairdate":"\(data.card.expiryMonth)/\(data.card.expiryYear)"] as [String : Any]
        
        //print(parameters)
        cartVM.addPaymentApi(parameters: parameters)
    }
    public func MakeOrder(paymetType:String){
        
//        if checkForError() {
            
            
            if isConnectedToInternet() {
                let copuneCode = tfCoupon.text!
                guard let userId = AppDelegate.getUserData()?.id else{return}
                var itemsStr = "["
                for item in cartVM.cartItemsArr ?? []
                {
                    
                    itemsStr.append("{\"id\":\(item.product_id ?? 0),\"qty\":\(item.qty ?? 0),\"unit_price\":\(item.qty_price ?? 0),\"total_price\":\(item.total_price ?? 0)},")
                }
                
                var newStr = itemsStr.dropLast()
                newStr.append("]")
                
                var sdAmount = "0.0"
                if tfWalletAmount.text != ""
                {
                    sdAmount = "\(tfWalletAmount.text!) ريال"
                }
                let parameters = [    "user_id":userId,
                                      "cart_id":cartVM.cartData?.cart_id! ?? 0,
                                      "ship_id":shippingId,
                                      "sd_amount":sdAmount,
                                      "ship_charge":cartVM.cartData?.shipping ?? 1,
                                      "tax": cartVM.cartData?.tax ?? 1,
                                      "total_payment":totalCaluctPrice ?? 0,
                                      "payment_type":paymetType,
                                      "time":timeString,
                                      "date":selectedDateForApi! ,
                                      "coupon_code":"\(copuneCode)",
                                      "coupon_id":cartVM.couponDetail?.coupon_id ?? 0,
                                      "discount":discount ?? 0,
                                      "campaign_id":0,
                                      "campaign_type":0,
                                      "campaign_value":0,
                                      "campaign_code":0,
                                      "additional_discount":0,
                                      "cart_items":newStr] as [String : Any]
                
                // print(parameters)
                cartVM.addOderApi(parameters: parameters)
            }else{
                showNoInternetAlert()
            }
//        }
 }
    
    
    
    
    
    // حساب اجمالي السعر-------------------
    func checkCoponWithTotalPrice(){
        let min = Double(cartVM.couponDetail?.minimum_amount ?? 0)
        var totprice = 0.0
        for item in cartVM.cartItemsArr ?? []
        {
            totprice += Double(item.total_price ?? 0)
        }
        
        let amount = Double(cartVM.couponDetail?.amount ?? 0)
        let tax = Double(cartVM.cartData?.tax ?? 0)
        let percentage = Double(cartVM.couponDetail?.percentage ?? 0)
        let shippingPrice =  Double(cartVM.cartData?.shipping ?? 0)

        if min  < totprice {
            if cartVM.couponDetail?.CouponType  == "OrderExcluding"{
                if cartVM.couponDetail?.is_amount ==  true{
            // ---------سعر المنتج بعدخصم amount --
               
                    orderPriceAfterDis = totprice - amount
                    
                         //الضريبة علي المنتج قبل خصمamount
                taxOnOrder = (tax*totprice)/100
                     
                    
                    //------------------ السعر اللي هبعته لل API---------
                totalCaluctPrice = orderPriceAfterDis! + taxOnOrder! + Double((cartVM.cartData?.shipping)!)
                    discount = (totprice - totalCaluctPrice!) //الخصم
                    lblTotal.text = "\(totalCaluctPrice ?? 0)" + "ريال"
                    lblTotalBeforDiscount.text = "\(Double(totprice + shippingPrice + taxOnOrder!))" + "ريال"

                    
                }else if cartVM.couponDetail?.is_amount == false {
                   // -----------------تطبق  نسبة الخصم---------//
                orderPriceAfterDis = Double(totprice * (100 - percentage))/100
                   // print(orderPriceAfterDis)
                                 //------الضريبة علي المنتج ققبل الخصم
                        taxOnOrder = (tax*totprice)/100
                    
                    // السعر اللي هبعته لل API
                totalCaluctPrice = orderPriceAfterDis! + taxOnOrder! + shippingPrice
                   // print(totalCaluctPrice)
                    discount = (totprice - totalCaluctPrice!) //الخصم
                    lblTotal.text = "\(totalCaluctPrice ?? 0)"
                    lblTotalBeforDiscount.text = "\(Double(totprice + shippingPrice + taxOnOrder!))" + "ريال"

                }
            }else if cartVM.couponDetail?.CouponType  == "OrderIncluding" {
                
                if cartVM.couponDetail?.is_amount ==  true{
                                 //الضريبة  علي المنتج قبل الخصم
                        taxOnOrder = (tax*totprice)/100
                    lblTotalBeforDiscount.text = "\(Double(totprice + shippingPrice + taxOnOrder!))" + "ريال"

                  //  print(taxOnOrder)
                    
              // السعر اللي هبعته لل API
        totalCaluctPrice = ((totprice + taxOnOrder! + shippingPrice) - amount)
            discount = (totprice - totalCaluctPrice!) //الخصم
                    lblTotal.text = "\(totalCaluctPrice ?? 0)"
                    lblTotalBeforDiscount.text = "\(Double(totprice + shippingPrice + taxOnOrder!))" + "ريال"

                }else if cartVM.couponDetail?.is_amount == false {
                  // ( سعر الاوردر+ الشحن + الضريبه علي المنتج )* النسبة
                    
                   // النسبة =  ١٠٠-النسبة\١٠٠
                orderPriceBeforDis = totprice
                                                            
                                         //الضريبة  علي المنتج ققبل الخصم
            taxOnOrder = (tax*totprice)/100
                    
                      // السعر اللي هبعته لل API
        let percentageOnOrder :Double?              //النسبة
            percentageOnOrder = (100 - percentage)/100
                    
                    totalCaluctPrice = (orderPriceBeforDis! + taxOnOrder! + shippingPrice) * Double(percentageOnOrder ?? 0)
                  
                    discount = (totprice - totalCaluctPrice!) //الخصم
                    lblTotal.text = "\(totalCaluctPrice ?? 0)"
                    lblTotalBeforDiscount.text = "\(Double(totprice + shippingPrice + taxOnOrder!))" + "ريال"

                    
                }
                
            }
            
        }else{
            showErrorAlert(message: "لا يمكن تطبيق الكوبون")
            totalCaluctPrice = totprice + shippingPrice + Double((taxOnOrder) ?? 0.0)
            discount = 0.0
            lblTotal.text = "\(totalCaluctPrice ?? 0)" + "ريال"
            lblTotalBeforDiscount.text = "\(totalCaluctPrice ?? 0)" + "ريال"
                
        }
        
       
        }
    
    func callGetCartApi(){
        guard let userID = AppDelegate.getUserData()?.id else{return}
        cartVM.getCartData(user_id: userID)
    }
    
}



extension CartVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == tfWalletAmount {
            if updatedText != "" {
            if Double(General.ChangeArabicNumbersToEnglish(arabicNumber: updatedText))! > cartVM.cartData?.wallet_amount ?? 0 {
                showErrorAlert(message: "رصيد محفظتك غير كافٍ" )
                textField.resignFirstResponder()
                //"your_wallet_balance_isnot_enough".localized
                return false
            }
                
            }
                        
        }
        return true
    }
   
}

extension CartVC:HeaderDelegate{
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension CartVC {
    
    @objc func SetSelectedAddressAction(notification: NSNotification)  {
        lblAddress.text = (notification.userInfo!["selectedAddress"] as! String)
        selectAddress = notification.userInfo!["selectedAddress"] as! String
//        selectedLong = notification.userInfo!["selectedLong"] as! String
//        selectedLat = notification.userInfo!["selectedLat"] as! String
        shippingId = notification.userInfo!["shippingId"] as! Int
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

extension CartVC
{
    func requestCheckoutID(type:String)
    {
      //"MASTER"//"VISA"
        paymentHandler = OnlinePaymentHandler()
        paymentHandler?.delegate = self
        paymentHandler?.paymentType = type
        HUD.show(.progress, onView: self.view)
        
//        paymentHandler?.theRequestCheckoutID(amount:Int(totalCaluctPrice ?? 1.0),cartId: cartObjc?.cart_id ?? 0,paymentMethod: type)
        paymentHandler?.theRequestCheckoutID(amount:Int(1.0),cartId: cartObjc?.cart_id ?? 0,paymentMethod: type)
    }
}
extension CartVC:  OnlinePaymentHandlerDelegate ,SFSafariViewControllerDelegate {
    func requestCheckoutIDFailed(error: String) {
        HUD.hide()
        showErrorAlert(message: "لم يتم الدفع")
    }
    
    func openSafari(withURL: URL) {
        self.presenterURL(url: withURL)
    }
    
    func closeSafari() {
        self.safariVC?.dismiss(animated: true, completion: {
            self.paymentHandler?.requestPaymentStatus(resourcePath: "")
        })
    }
    
    func transactionFailed(error: String?) {
        
        HUD.hide()
        showErrorAlert(message: error ?? "")

       
    }
    
    func storeCardFailed(error: String?) {
        HUD.hide()
        
        showErrorAlert(message: error ?? "")
    }
    
    func storeCardSuccess() {
        showErrorAlert(message: "Card_added_Successfully")

        self.dismiss(animated: true, completion:nil)
        
    }
    
    func confirmCardSuccess(transactionId:String)
    {
        //pay for offer >> back to offer screen
        UserDefaults.standard.setValue(transactionId, forKey: "transactionIdFromPay")
        if self.presentingViewController != nil
        {
            self.presentingViewController!.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: .init("payOnlineSuccess"), object: nil)
            })
        }
        else
        {
            self.dismiss(animated: true, completion: { [self] in
                showErrorAlert(message: "payOnlineSuccess")

                NotificationCenter.default.post(name: .init("payOnlineSuccess"), object: nil)
            })
        }
    }
    
    func presenterURL(url: URL) {
        safariVC = SFSafariViewController(url: url)
        safariVC?.delegate = self;
        self.present(safariVC!, animated: true, completion: nil)
    }
    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true) {
            self.paymentHandler?.requestPaymentStatus(resourcePath: "")
        }
    }
}

