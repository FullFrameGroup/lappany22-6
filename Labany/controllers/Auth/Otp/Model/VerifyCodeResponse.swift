//
//  VerifyCodeModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/12/21.
//

import Foundation
struct VerifyCodeResponse: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:OtpModel?
}

struct OtpModel: Codable {
    var otp:String?
}
