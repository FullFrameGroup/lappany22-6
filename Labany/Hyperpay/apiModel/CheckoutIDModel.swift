//
//  CheckoutIDModel.swift
//  Labany
//
//  Created by Eman Gaber on 25/05/2022.
//

import Foundation

struct CheckoutIDModel: Codable {
    let checkoutID: String?
    let success: Bool?
    let code: Int?
    let data: CheckOutData?
    let msg:String?
    
    enum CodingKeys: String, CodingKey {
        case checkoutID = "checkoutId"
        case success, code, data,msg
    }
}

// MARK: - DataClass
struct CheckOutData: Codable {
    let method, amount: String?
    let resourcePath, redirect, merchantTransactionID, merchantInvoiceID: String?
    let billingStreet1, billingStreet2, billingCity, billingState: String?
    let billingPostcode, billingCountry: String?
    let merchantCustomerID: String?
    let givenName, surname, customerEmail: String?

    enum CodingKeys: String, CodingKey {
        case method, amount, resourcePath, redirect
        case merchantTransactionID = "merchantTransactionId"
        case merchantInvoiceID = "merchantInvoiceId"
        case billingStreet1 = "billing_street1"
        case billingStreet2 = "billing_street2"
        case billingCity = "billing_city"
        case billingState = "billing_state"
        case billingPostcode = "billing_postcode"
        case billingCountry = "billing_country"
        case merchantCustomerID = "merchant_customerId"
        case givenName = "given_name"
        case surname
        case customerEmail = "customer_email"
    }
}
struct PaymentCheckResponse: Codable {
    let code: Int
    let data: DataClass
    let msg: String
    let success: Bool
}

struct DataClass: Codable {
    //let resourcePath: String
    let response: ResponseClass
}

struct ResponseClass: Codable {
    let buildNumber: String
    let card: Card2
    let id: String
    let merchantInvoiceId: String
    let merchantTransactionId: String
    let ndc: String
    let paymentBrand: String
    let paymentType: String
    let timestamp: String
}

struct Card2: Codable {
    let bin: String
    let binCountry: String
    let binType: String
    let country: String
    let expiryMonth: String
    let expiryYear: String
    let holder: String
    let issuer: Issuer
    let last4Digits: String
    let level: String
    let maxPanLength: String
    let regulatedFlag: String
    let type: String
}

struct Issuer: Codable {
    let bank: String
    let website: String
}
