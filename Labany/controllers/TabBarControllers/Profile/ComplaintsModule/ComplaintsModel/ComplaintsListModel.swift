//
//  ComplaintsListModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/31/21.
//

import Foundation
import Foundation
struct ComplaintsListResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : [ComplaitsList]?
}


struct ComplaitsList : Codable {
    let complaint_number : Int?
    let complaint_title : String?
    let complaint_description : String?
    let is_reviewed : Int?
    let complaint_date : String?
}
