//
//  OnlinePaymentHandler.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 3/31/21.
//

import Foundation
import SafariServices
import PKHUD

enum CardParamsError: Error {
    case invalidParam(String)
}

@objc
protocol OnlinePaymentHandlerDelegate {
    func requestCheckoutIDFailed(error: String)
    func openSafari(withURL: URL)
    func closeSafari()
    func transactionFailed(error: String?)
    
    @objc optional func storeCardFailed(error: String?)
    @objc optional func storeCardSuccess()
    @objc optional func confirmCardSuccess(transactionId:String)
    
}

class OnlinePaymentHandler: NSObject {
    
    // MARK: - Other constants
    static let asyncPaymentCompletedNotificationKey = "AsyncPaymentCompletedNotificationKey"
    
    let shopperLink = "com.aait.nokhba2"
    
    var safariVC: SFSafariViewController?
    var card: Card?
    var payByCard = false
    var transactionId = ""
    
    var checkoutProvider: OPPCheckoutProvider?
    let provider = OPPPaymentProvider.init(mode: .live)
    let applePayProvider = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.com.aait.nokhba", countryCode: "SA")
    
    var transaction: OPPTransaction?
    var delegate: OnlinePaymentHandlerDelegate?
    var paymentType :String = ""
    var amount = 0
    var checkoutID: String? {
        didSet {
            if checkoutID != nil, !(checkoutID?.isEmpty ?? true) {
                createTransaction()
            }
        }
    }
    
    var paymentStatusDetails: PaymentStatus? {
        didSet {
            if let paymentStatusDetails = paymentStatusDetails {
                
                var tempCard = Card(holderName: "", bin: "", binCountry: "", expiryMonth: "", expiryYear: "", lastDigits: "", type: "", registrationId: "", id: 0, isDefault: false)
                
                tempCard.bin = paymentStatusDetails.card?.bin
                tempCard.binCountry = paymentStatusDetails.card?.binCountry
                tempCard.expiryMonth = paymentStatusDetails.card?.expiryMonth
                tempCard.expiryYear = paymentStatusDetails.card?.expiryYear
                tempCard.lastDigits = paymentStatusDetails.card?.last4Digits
                tempCard.registrationId = paymentStatusDetails.registrationId
                tempCard.holderName = paymentStatusDetails.card?.holder
                tempCard.bankName = paymentStatusDetails.card?.issuer?.bank
                
                tempCard.type = paymentType
                if transactionId == "" {
                    self.transactionId = paymentStatusDetails.merchantTransactionId ?? ""
                }
                
                card = tempCard
                if payByCard == true
                {
                    self.delegate?.confirmCardSuccess!(transactionId:self.transactionId)
                }else
                {
                    storeCardInfo()
                }
            }
        }
    }
    
    
    func theRequestCheckoutID(amount: Int,cartId:Int,paymentMethod:String)
    {// 1 //amount
        PaymetEndPoint.createCheckOutApi(amount: amount, method: "payment",merchantTransactionId:cartId, paymentMethod: paymentMethod) { (checkoutID, error) in
            if let error = error {

                self.delegate?.requestCheckoutIDFailed(error: error)
            } else {
                HUD.hide()
                self.amount = amount
                self.checkoutID = checkoutID
            }
        }
    }
    
    func createTransaction() {
        guard let checkoutID = checkoutID
        else {
            delegate?.transactionFailed(error: "لا يمكن إجراء معاملتك الآن! حاول لاحقا.")
            return
        }
        
        let checkoutSettings = OPPCheckoutSettings()
        checkoutSettings.theme.confirmationButtonColor = General.hexStringToUIColor(hex: "172B5D")
        checkoutSettings.theme.accentColor = General.hexStringToUIColor(hex: "172B5D")
        checkoutSettings.theme.textFieldBorderColor = General.hexStringToUIColor(hex: "172B5D")
        checkoutSettings.theme.navigationBarBackgroundColor = General.hexStringToUIColor(hex: "172B5D")
        checkoutSettings.theme.sectionBackgroundColor = General.hexStringToUIColor(hex: "172B5D")
        checkoutSettings.language = MOLHLanguage.currentAppleLanguage()
        
        if paymentType == "APPLEPAY"  {
            
            applePayProvider.supportedNetworks = [.visa ,.mada , .masterCard]
            checkoutSettings.applePayPaymentRequest = applePayProvider
            checkoutSettings.paymentBrands = ["APPLEPAY"]
            // Set shopper result URL
            checkoutSettings.shopperResultURL = shopperLink + "://result"
        }
        else
        {
            checkoutSettings.paymentBrands = [paymentType]
//             Set shopper result URL
            checkoutSettings.shopperResultURL = shopperLink + "://result"
            
        }
        
        checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
        checkoutProvider?.delegate = self
        
        // Since version 2.13.0
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            guard let transaction = transaction else {
                // Handle invalid transaction, check error
                self.delegate?.transactionFailed(error: error?.localizedDescription)
                
                return
            }
            
            self.transaction = transaction
            if transaction.type == .synchronous {
                // If a transaction is synchronous, just request the payment status
                // You can use transaction.resourcePath or just checkout ID to do it
              //  let ivoiceID = self.transaction?.paymentParams?.customParams
                self.requestPaymentStatus(resourcePath: self.transaction?.resourcePath ?? "")
                
            } else if transaction.type == .asynchronous {
                // The SDK opens transaction.redirectUrl in a browser
                // See 'Asynchronous Payments' guide for more details
                
                NotificationsManager.observeNotification(withName: .didPaySuccessfully, observer: self, selector: #selector(self.didReceiveAsynchronousPaymentCallback))
                
                //  self.delegate?.openSafari(withURL: self.transaction!.redirectURL!)
                
                
                
            } else {
                // Executed in case of failure of the transaction for any reason
                self.delegate?.transactionFailed(error: error?.localizedDescription)
            }
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
        })
        
        
        
    }
    
    
    func requestPaymentStatus(resourcePath:String) {
        guard let checkoutID = checkoutID else {
            delegate?.transactionFailed(error:"لا يمكن إجراء معاملتك الآن! حاول لاحقا.")
            return
        }
        
        self.transaction = nil
        self.provider.requestCheckoutInfo(withCheckoutID: checkoutID, completionHandler: { (transactionInfo, error) in
            
            if transactionInfo != nil {
                PaymetEndPoint.checkPaymentStatus(merchantTransactionId: "\(General.sharedInstance.cartID)", merchantInvoiceId: "\(General.sharedInstance.cartID)", resourcePath: resourcePath, method: "check_payment") { (result, error) in
                    if let result = result {
                        print(result.msg)
                        //self.paymentStatusDetails = result
                        
                        NotificationCenter.default.post(name: Notification.Name("callMakeOrderAPi"),object: nil,userInfo:["paymet_type":self.paymentType,"checkout_id":self.checkoutID!,"data":result.data.response])

                        
                    } else {
//                        NotificationCenter.default.post(name: Notification.Name("callMakeOrderAPi"),object: nil,userInfo:["paymet_type":self.paymentType,"checkout_id":self.checkoutID!,"data":result?.data.response])
                        self.delegate?.transactionFailed(error: error)
                    }
                }
            } else {
                self.delegate?.transactionFailed(error: error?.localizedDescription)
            }
        })
        
        
    }
    
    func storeCardInfo() {
        guard let card = card else {
            delegate?.transactionFailed(error: "We can't store your card info right now!. try again later")
            return
        }
    }
    
    @objc
    func didReceiveAsynchronousPaymentCallback() {
        NotificationsManager.removeNotification(observer: self, withName: .didPaySuccessfully)
        
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                self.requestPaymentStatus(resourcePath: self.transaction?.resourcePath ?? "")
            }
        }
    }
    
    func resetPaymentData() {
        checkoutID = nil
        paymentStatusDetails = nil
    }
}

extension OnlinePaymentHandler: OPPCheckoutProviderDelegate {
    @IBAction func checkoutButtonAction(_ sender: UIButton) {
        // Set a delegate property for the OPPCheckoutProvider instance
        self.checkoutProvider!.delegate = self
    }
    
    
    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, applePayDidSelectShippingContact contact: PKContact, handler completion: @escaping (OPPApplePayRequestShippingContactUpdate) -> Void) {
        // You may want to provide different shipping methods based on shipping information
        //        let shippingMethods = self.shippingMethods(contact: contact)
        
        // You may want to change amount of transaction (e.g. by adding tax) based on shipping information
        //        self.contact = contact
        //        updateSummaryItems()
        //
        //        let update = OPPApplePayRequestShippingContactUpdate.init(errors: nil, paymentSummaryItems: self.summaryItems, shippingMethods: shippingMethods)
        //        completion(update)
    }
    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, applePayDidSelect shippingMethod: PKShippingMethod, handler completion: @escaping (OPPApplePayRequestShippingMethodUpdate) -> Void) {
        // You may want to change amount of transaction based on shipping method cost
        //        self.shippingMethod = shippingMethod
        //        updateSummaryItems()
        //
        //        let update = OPPApplePayRequestShippingMethodUpdate.init(paymentSummaryItems: self.summaryItems)
        //        completion(update)
    }
    
    
}
