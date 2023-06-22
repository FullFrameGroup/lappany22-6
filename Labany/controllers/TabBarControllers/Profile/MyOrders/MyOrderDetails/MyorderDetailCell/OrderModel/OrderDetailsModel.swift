//
//  OrderDetailsModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/3/21.
//

import Foundation

struct OrderDetailsResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : OrderDetails?
}

struct OrderDetails : Codable {
    let order : [OrderModel]?
}

struct OrderDetailsModel : Codable {
    let o_id : Int?
    let cart_id : Int?
    let iscancel : String?
    let shipping : Int?
    let wallet_amount : Int?
    let tax : Int?
    let total : Int?
    let order_status_str : String?
    let order_status : String?
    let payment_type : String?
    let date : String?
    let time : String?
    let address : Address?
    let cart_item : [CartItems]?
}

