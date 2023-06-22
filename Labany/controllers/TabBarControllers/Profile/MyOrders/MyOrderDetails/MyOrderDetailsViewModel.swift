//
//  MyOrderDetailsViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/2/21.
//

import Foundation
protocol MyOrderDetailsViewModelDelegate: class {

    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func getOrderDetailsSuccessfully(order:[OrderModel])
  

}
//
class MyOrderDetailsViewModel {

    weak var delegate: MyOrderDetailsViewModelDelegate?
    init(delegate:MyOrderDetailsViewModelDelegate?) {
        self.delegate = delegate
    }
    var orderDetailArr:[OrderModel]?
    var orderItemsArr:[CartItems]?
  

    func getorderDetails(user_id:Int,order_id: Int ) {
        self.delegate?.showLoading()
        OrderDetailsWebServices.orderDetailsApi(user_id:user_id, order_id: order_id ){ [self] (data, error) in
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
        orderDetailArr = data?.data?.order
        
        orderItemsArr = data?.data?.order?.first?.cart_item!
        
        self.delegate?.getOrderDetailsSuccessfully(order:orderDetailArr ?? [])
       }
   }

}
    
 
   
}
