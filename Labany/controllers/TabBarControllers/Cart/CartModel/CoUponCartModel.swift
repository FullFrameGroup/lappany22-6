//
//  CoUponCartModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation
struct CoUponCartModel:Codable {
    var success:Bool?
    var code:Int?
    var msg:String?
    var data:CouponData?
}
struct CouponData:Codable {
    var Coupon:CouponDetails?

}

struct CouponDetails:Codable {
    var minimum_amount :Int?
    var coupon_id :Int?
    var CouponType :String?
    var percentage :Int?
    var amount :Int?
    var is_amount :Bool?
}


