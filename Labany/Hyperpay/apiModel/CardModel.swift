//
//  CardModel.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 3/15/21.
//

import Foundation

struct CardModel: Codable {
    let status: Int?
    let message: String?
    let data: [Card]?
}

struct Card: Codable {
    var holderName: String?
    var bin: String?
    var binCountry: String?
    var expiryMonth: String?
    var expiryYear: String?
    var lastDigits: String?
    var type: String?
    var registrationId: String?
    var bankName: String?

    // For Decodable
    var id: Int?
    var isDefault: Bool?
}
