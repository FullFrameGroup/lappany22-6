//
//  CartViewMOdel+delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/25/21.
//

import Foundation
import UIKit

extension CartVC : CartOrderViewModelDelegate {
    func catchError() {
        
    }
    
    func getCartTimes(times: [TimesOpen]?) {
            titleTimesArr = times
            loadTimesMenu()
    }
    
    
    
    func deleteItemSuccessfully(msg: String) {
        showMessage(msg: msg, type: .success)
        viewEmptyCart.isHidden = false
        
        if cartVM.cartData == nil || cartVM.cartItemsArr?.count == 0
        {
            cartTable.isHidden = true
            tableHeight.constant = 0
            viewScrrollHeight.constant  = 475
            self.loadViewIfNeeded()
           // showMessage(msg: "السلة فارغة", type: .error)
            scrollView.isHidden = true
            btnMakeOrderrCash.isHidden = true
           
            
        }else
        {
            
            tableHeight.constant = CGFloat(86 * cartVM.cartItemsArr!.count) + 67 // 67 >> table header
            viewScrrollHeight.constant = tableHeight.constant + 475  //all fixed view + table height
            self.loadViewIfNeeded()
            
            cartTable.reloadData()
            lblWalletAmoumt.text = "\(cartVM.cartData?.wallet_amount ?? 0 )ر.س"
            calculateTotalPriceForAllItems()
        }
    }
    
    func fetchCartItemsSuccessfully() {
        
        if   cartVM.cartData == nil ||  cartVM.cartItemsArr == nil
        {
            cartTable.reloadData()
            viewEmptyCart.isHidden  = false
            tableHeight.constant = 0
            viewScrrollHeight.constant  = 475
            self.loadViewIfNeeded()

            scrollView.isHidden = true
            btnMakeOrderrCash.isHidden = true

        }else
        {
        cartTable.reloadData()
            viewEmptyCart.isHidden  = true

            tableHeight.constant = CGFloat(86 * (cartVM.cartItemsArr?.count)!) + 67 // 67 >> table header
            
            viewScrrollHeight.constant = tableHeight.constant + 475  //all fixed view + table height
            self.loadViewIfNeeded()
            lblWalletAmoumt.text = "\(cartVM.cartData?.wallet_amount ?? 0 ) ر.س"
            calculateTotalPriceForAllItems()
            
            
            let dayesOpen = cartVM.cartData?.date_setting?.avaliable_days ?? 0
            let avaliableDayes:Int = cartVM.cartData?.date_setting?.avaliable_days ?? 0

            print(dayesOpen)
            datepickerr.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
            datepickerr.maximumDate = Calendar.current.date(byAdding: .day, value: avaliableDayes - 1, to: Date())
            datepickerr.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())

         
           
        }
        
    }
    func hideSelectDateView(_ hide: Bool) {
        viewDate.isHidden = hide
    }
    func fetchVisaSuccessfully() {
        visaCollection.reloadData()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)
    }
    
    func orderAddedSuccessfully(msg:String)
    {
        showMessage(msg: msg, type: .success)
        self.dismiss(animated: true, completion: nil)
    }
    
    func orderAddFail(message:String)
    {
        showErrorAlert(error: message)
    }
    
    func cashingSuccessfully(msg:String) {
        showMessage(msg: msg, type: .success)
        checkCoponWithTotalPrice()
    }
}
