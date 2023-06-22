//
//  MyOrdersListViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import Foundation
import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController

protocol MyOrdersListViewModelDelegate: class {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func GetMyOrdersSuccessfully(orders:[OrderModel])
    func deleteMyOrderSuccessfully()
    func deleteOrderSuccessfully(msg:String)
}

class MyOrdersListViewModel {
    weak var delegate: MyOrdersListViewModelDelegate?
    init(delegate:MyOrdersListViewModelDelegate?) {
        self.delegate = delegate
    }
    
    var ordersArr:[OrderModel]?
    var cartItemsArr:[CartItems]?
    func getMyOrdersList(userId:Int) {
        self.delegate?.showLoading()
        
        MyOrdersListWebServices.getMyOrdersApi(user_id:userId ){ [self] (data, error) in
            self.delegate?.killLoading()
            
            if error == nil && data == nil {
                print("Connection failed")
                self.delegate?.connectionFailed()
                
            } else if (error != nil)  {
                
                self.delegate?.showErrorAlert(error: error ?? "")
                
            } else if (data?.success == false){
                self.delegate?.showErrorAlert(error: data?.msg ?? "")
                
            }
            else if (data?.success == true){
                cartItemsArr = (data?.data?.order?.first?.cart_item ?? [])
                ordersArr = (data?.data?.order ?? [])
                self.delegate?.GetMyOrdersSuccessfully(orders: ordersArr ?? [] )
                
                
            }
        }
        
    }
    
    
    func deleteAddressApi(user_id:Int,order_id:Int) {
        
        MyOrdersListWebServices.deleteOrderApi(user_id:user_id,order_id: order_id){ [self] (data, error) in
            self.delegate?.killLoading()
            
            if error == nil && data == nil {
                print("Connection failed")
                self.delegate?.connectionFailed()
                
            } else if (error != nil)  {
                
                self.delegate?.showErrorAlert(error: error ?? "")
                
            } else if (data?.success == false){
                self.delegate?.showErrorAlert(error: data?.msg ?? "")
                
            }
            else if (data?.success == true){
                // Address deleted Successfully
                
                self.delegate?.deleteOrderSuccessfully(msg: data?.msg ?? "")
                
            }
            
        }
    }
    
}
