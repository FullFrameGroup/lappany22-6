//
//  VisaModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/3/21.
//

import Foundation
struct VisaResponse: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:[VisaModel]?
}
struct VisaModel: Codable {
    var visa_id:Int?
    var visa_type:String?
    var visa_type_img:String?
    var card_holder_name:String?
    var card_number:String?
    var cart_date:String?
    var secret_code:String?


}
