//
//  AddAddressResponse.swift
//  Labany
//
//  Created by Eman Gaber on 7/28/21.
//

import Foundation
struct AddAddressResponse :Codable{
    var success:Bool?
    var code:Int?
    var msg:String?
    var data:ShippigId?
}
struct ShippigId :Codable{
    var shipping_id :Int?
}
