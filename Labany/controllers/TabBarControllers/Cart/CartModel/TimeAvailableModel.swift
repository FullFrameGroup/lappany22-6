//
//  TimeAvailableModel.swift
//  Labany
//
//  Created by Mac on 23/08/2021.
//

import Foundation

struct mrketTimes:Codable {
    
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:timeData?
}
struct timeData:Codable {
    var time_slot:[TimesOpen]?
}

struct TimesOpen:Codable {
    var id:Int?
    var from_time:String?
    var to_time:String?
}


