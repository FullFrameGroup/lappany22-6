//
//  RateOrderModel.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import Foundation


struct RateOrderresponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : AllQuestions?
}

struct AllQuestions : Codable {
    let feedback_questions : [questions]?
}

struct questions : Codable {
    var id:Int?
    var title:String?
}


