//
//  TermsModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation


struct TermsModel:Codable {
    var success:String?
    var code:Int?
    var msg:String?
    var  data:dataRespons?
}
struct dataRespons:Codable {
    var content:String?
}
