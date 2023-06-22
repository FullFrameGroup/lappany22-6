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
//    var data:MakeOrderData?
}
struct MakeOrderData: Codable {
    var cart_id :Int?
    
}
