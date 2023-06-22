

import Foundation
struct PaymentStatusModel : Codable {
	let status : Int?
	let message : String?
	let data : PaymentStatus?
}

struct PaymentStatus : Codable {
    let id : String?
    let paymentType : String?
    let registrationId : String?
    let paymentBrand : String?
    let amount : String?
    let currency : String?
    let descriptor : String?
    let merchantTransactionId : String?
    let result : ResultModel?
    let resultDetails : ResultDetailsModel?
    let card : CardDetailsModel?
    let customer : CustomerModel?
    let billing : BillingModel?
    let customParameters : CustomParametersModel?
    let risk : RiskModel?
    let buildNumber : String?
    let timestamp : String?
    let ndc : String?
}

struct ResultModel : Codable {
    let code : String?
    let description : String?
}

struct CustomParametersModel : Codable {
    let SHOPPER_MSDKIntegrationType : String?
    let SHOPPER_device : String?
    let CTPE_DESCRIPTOR_TEMPLATE : String?
    let SHOPPER_OS : String?
    let SHOPPER_MSDKVersion : String?
}

struct BillingModel : Codable {
    let street1 : String?
    let city : String?
    let state : String?
    let country : String?
}
struct CardDetailsModel : Codable {
    let bin : String?
    let binCountry : String?
    let last4Digits : String?
    let holder : String?
    let expiryMonth : String?
    let expiryYear : String?
    let issuer:IssuerModel?
}

struct IssuerModel : Codable {
    let bank : String?
    let website : String?
    let phone : String?
    
}


struct RiskModel : Codable {
    let score : String?
}

struct ResultDetailsModel : Codable {
    let ConnectorTxID1 : String?
}

struct CustomerModel : Codable {
    let surname : String?
    let email : String?
    let ip : String?
    let ipCountry : String?
}
