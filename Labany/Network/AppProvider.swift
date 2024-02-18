//
//  AppProvider.swift
//  Labany
//
//  Created by iMac on 05/08/2021.
//

import Foundation
import Moya

enum AppProvider {

    case addToCart(userId:Int,param:[String : Any])
    case addOrder(param:[String : Any])
    case addRate(param:[String : Any])
    case addPayment(param:[String:Any])

}

extension AppProvider: TargetType {
    
    //==================
    //MARK: Base URL
    //==================

    var baseURL: URL {
        let baseURLString = "https://nokhbaapp.com/new/api_v4/"

        return URL(string: baseURLString)!
    }
    
    //==================
    //MARK: Path
    //==================
    var path: String {
        switch self {

        case let .addToCart(userId,_):
            return "add_cart.php/\(userId)"
        case  .addOrder:
            return "add_new_order.php"
            
        case .addRate:
            return "save_feedback_questions.php"
        case .addPayment:
            return "add_payment_detail.php"
        }
    }
    
    //==================
    //MARK: parameters
    //==================
    var parameters: [String: Any] {
        switch self {
        case let .addToCart(_,param):
            return param

        case .addOrder(let param):
            return param
            
        case .addRate(let param):
            return param
        case .addPayment(let param):
            return param
        default:
            return [:]
        }
    }
    
    //==================
    //MARK: Method
    //==================
    var method: Moya.Method {
        switch self {
        case .addToCart, .addOrder, .addRate,.addPayment:
            return .post

        }
    }
    
    //======================
    //MARK: sampleData
    //======================
    var sampleData: Data {
        return Data()
    }
    
    //======================
    //MARK: Task
    //======================
    var task: Task {
        switch self {
        case .addToCart, .addOrder,.addRate,.addPayment:
            return .requestParameters(parameters: self.parameters, encoding: JSONEncoding.default)
      
        }
    }
    
    //======================
    //MARK: headers
    //======================
    var headers: [String : String]? {

        let headers : [String : String]? = ["x_api_key":"WYLUnBhBpGltg?##$%%^Y##$GZWcXfIW","Content-Type":"application/x-www-form-urlencoded"]
        
        return headers
    }
}


//
extension Dictionary {
    static func += (lhs: inout [Key:Value], rhs: [Key:Value]) {
        lhs.merge(rhs){$1}
    }
    static func + (lhs: [Key:Value], rhs: [Key:Value]) -> [Key:Value] {
        return lhs.merging(rhs){$1}
    }
}


extension Encodable {
    func dictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        //        encoder.dateEncodingStrategy = .millisecondsSince1970
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let json = try? encoder.encode(self),
              let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
            return nil
        }
        return dict
    }
}
