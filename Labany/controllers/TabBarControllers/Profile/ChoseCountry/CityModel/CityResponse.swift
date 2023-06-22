//
//  CityResponse.swift
//  Labany
//
//  Created by Eman Gaber on 7/17/21.
//

import Foundation
struct CityResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : DataModel?
}

struct DataModel : Codable {
    let cities : [Cities]?
    let tax_vat : String?
}
struct Cities : Codable {
    let city_id : Int?
    let city_name : String?
    let city_name_arabic : String?
    let shipping_charge : String?
}

struct TermsResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : TermsData?
}

struct TermsData : Codable {
    let content : String?
}
