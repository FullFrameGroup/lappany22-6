//
//  WalletModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/26/21.
//

import Foundation

struct WalletResponse : Codable {
    let success : Bool?
    let code : Int?
    let msg : String?
    let data : WalletDataModel?
   
  
}
struct WalletDataModel : Codable {
    let wallet_amount : Double?
    let wallet_list : [Walletlist]?

}

struct Walletlist : Codable {
    let amount : Double?
    let description : String?
    let date_time : String?

}
