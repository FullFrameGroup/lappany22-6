//
//  MyOrderModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import Foundation

struct MyOrdersResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : CartItemsList?
}

struct CartItemsList : Codable {
    let order : [OrderModel]?
}

struct OrderModel : Codable {
    let o_id : Int?
    let cart_id : Int?
    let iscancel : String?
    let shipping : Double?
    let wallet_amount : Double?
    let tax : Double?
    let total : Double?
    let discount :Double?
    let order_status_str : String?
    let order_status : String?
    let payment_type : String?
    let date : String?
    let time : String?
    let is_feedback_given: String?
    let address : Address?
    let cart_item : [CartItems]?
}
struct Address : Codable {
    let shipping_id : Int?
    let user_id : Int?
    let title : String?
    let city_id : Int?
    let city_english : String?
    let city_arabic : String?
    let city_name : String?
    let location : String?
    let alter_name : String?
    let alter_contact : String?
    let district_name : String?
    let latitude : Double?
    let longitude : Double?
}
struct CartItems : Codable {
    let cart_item_id : Int?
    let cart_id : Int?
    let product_id : Int?
    let product_type : String?
    let product_name : String?
    let product_image : String?
    let total_price : Int?
    let qty : Int?
    let qty_price : Int?
    let extra_id : Int?
    let extra_name : String?
    let extra_price : Int?
    let packing_id : Int?
    let packing_name : String?
    let packing_price : Int?
    let size_id : Int?
    let size_name : String?
    let size_price : Int?
    let cut_id : Int?
    let cut_name : String?
    let cut_price : Int?
    let notes : String?
}
