//
//  ProductDetailsModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/25/21.
//

import Foundation
struct ProductDetailsResponse: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:ProductDataModel?
}
struct ProductDataModel: Codable {
    var product_detail :[ProductDetailsModel]?
    
}
struct ProductDetailsModel: Codable {
    var productId :Int?
    var productName :String?
    var productNameUrdu :String?
    var productType :Int?
    var productDescription :String?
    var productLogo :String?
    var extra :[ExtraModel]?
    var packing :[PackingModel]?
    var size :[SizeModel]?
    var cut_piece :[CutModel]?
}

struct ExtraModel:Codable {
    var extra_id : Int?
    var extra_type : String?
    var extra_price : Double?
    var display_order : String?
}

struct PackingModel:Codable  {
    var packing_id : Int?
    var packing_type : String?
    var packing_price : Double?
    var display_order : String?
}
struct SizeModel:Codable  {
    var size_id:Int?
    var size_type:String?
    var size_price:Double?
    var display_order:String?
}

struct CutModel:Codable  {
    var cut_piece_id : Int?
    var cut_piece_type : String?
    var cut_piece_price : Double?
    var display_order : String?
}
        
