//
//  RegistrationResponse.swift
//  Labany
//
//  Created by iMac on 05/07/2021.
//

import Foundation
struct RegistrationResponse: Codable {
    
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:UserIdModel?
}

struct UserIdModel: Codable {
    var id:Int?
}

