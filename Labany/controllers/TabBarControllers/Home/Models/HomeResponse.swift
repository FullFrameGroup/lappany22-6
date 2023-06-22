//
//  HomeResponse.swift
//  Labany
//
//  Created by Eman Gaber on 7/14/21.
//

import Foundation

struct HomeResponse: Codable {
    var success: Bool?
    var code:Int?
    var msg:String?
    var data:HomeDataModel?
}

struct HomeDataModel: Codable {
    var categories:[CategoryModel]?
    var banners:[BannerModel]?
}

struct CategoryModel: Codable {
    var id:Int?
    var categoryName:String?
    var products:[ProductModel]?
}

struct BannerModel: Codable {
    var id:Int?
    var bannerimage: String?
    var bannerdetails: String?
}

struct ProductModel: Codable {
    
    var productId:Int?
    var productName: String?
    var productNameUrdu:String?
    var product_type:Int?
    var productImage:String?
}
