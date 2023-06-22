//
//  AddressListModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
struct AddressListResponse :Codable{
    var success:Bool?
    var code:Int?
    var msg:String?
    var data:ShippingModel?
}


struct ShippingModel:Codable {
    var shipping : [shippingArrressList]
}

struct shippingArrressList:Codable {
    var shipping_id : Int?
    var user_id : Int?
    var city : String?
    var city_arabic : String?
    var city_name : String?
    var shipping_charge : String?
    var city_id : Int?
    var location : String?
    var alter_name : String?
    var alter_contact : String?
    var district_name : String?
    var latitude : Double?
    var longitude : Double?
    var is_selected : String?
}
