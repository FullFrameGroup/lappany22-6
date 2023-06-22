//
//  deletAccountModel.swift
//  Labany
//
//  Created by Eman Gaber on 07/07/2022.
//

import Foundation

struct DeleteAccountResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : String?
}
