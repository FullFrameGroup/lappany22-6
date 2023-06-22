//
//  CartModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/18/21.
//

import Foundation

struct CartResponse: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:CartModel?
}

struct CartModel: Codable {
    var cart_id:Int?
    var shipping:Int?
    var tax:Int?
    var wallet_amount:Double?
    var visa_types:[VisaTypeModel]?
    var cart_items:[CartItemsModel]?
    var date_setting:dateAvaliable?
}


struct VisaTypeModel: Codable {
    var visa_type_id:Int?
    var visa_type_name:String?
    var visa_type_img:String?
}


struct CartItemsModel:Codable {
    
    var cart_item_id:Int?
    var product_id:Int?
    var product_type:Int?
    var product_name:String?
    var product_image:String?
    var total_price:Int?
    var qty:Int?
    var qty_price:Int?
    var extra_id:Int?
    var extra_name:String?
    var extra_price:Double?
    var packing_id:Int?
    var packing_name:String?
    var packing_price:Double?
    var size_id:Int?
    var size_name:String?
    var size_price:Double?
    var cut_id:Int?
    var cut_name:String?
    var cut_price:Double?
    var notes:String?

}

struct dateAvaliable:Codable {
    var avaliable_days:Int?
    var open:String?
}


