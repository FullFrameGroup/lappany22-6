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
