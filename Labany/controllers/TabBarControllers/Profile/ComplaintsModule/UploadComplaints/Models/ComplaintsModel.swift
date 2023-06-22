//
//  File.swift
//  Labany
//
//  Created by Eman Gaber on 7/29/21.
//


import Foundation
struct ComplaintsResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : TypesModel?
}


struct TypesModel : Codable {
    let complaint_type : [ComplaintTypes]?
}

struct ComplaintTypes : Codable {
    let complaint_type_id : Int?
    let title : String?
}

