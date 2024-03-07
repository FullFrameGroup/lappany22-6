//
//  MakeOrderModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/4/21.
//

import Foundation
import Foundation
struct MakeOrderModel: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:MakeOrderData?
}
struct MakeOrderData: Codable {
    var cart_id :Int?
    var order_id:Int?
    var wallet_amount:Double?
}
struct MakeOrderModel2: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:MakeOrderData2?
}
struct MakeOrderData2: Codable {
    var cart_id :String?
//    var order_id:Int?
//    var wallet_amount:Double?
}
