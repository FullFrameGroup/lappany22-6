//
//  SigneInModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import Foundation

struct SigneInModel: Codable{
    var success: Bool?
    var msg: String?
    var code : Int?
    var data: User?
    
}

struct User: Codable{
    var id: Int?
    var username: String?
    var email:String?
    var phone: String?
    var image:String?
    var city_id: Int?
    var city_name: String?
    var fcm_token: String?
    var wallet_amount:Int?
    
}



extension AppDelegate {
    
    class func setUserData(user:User?){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedPerson")
            
            let token = AppDelegate.getUserData()?.fcm_token
            print(token ?? "lll")
        }
    }
    
    class func getUserData()-> User?{
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(User.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return nil
    }
    
    class func deleteUserData(){
      UserDefaults.standard.removeObject(forKey: "SavedPerson")
    }
    
    
}
