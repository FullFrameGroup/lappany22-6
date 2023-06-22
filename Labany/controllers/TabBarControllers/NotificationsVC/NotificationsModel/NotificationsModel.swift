//
//  NotificationsModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation
struct NotificationsResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : NotificationsModel?
}

struct NotificationsModel : Codable {
    let notification : [Notifications]?
}
struct Notifications : Codable {
    let notification_id : Int?
    let notification : String?
    let notificationDate : String?
}
