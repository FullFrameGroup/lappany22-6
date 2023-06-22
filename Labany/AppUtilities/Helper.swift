//
//  Helper.swift
//  EkratFozan
//
//  Created by Eman Gaber on 6/9/21.
//  Copyright © 2021 Eman Gaberr. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class Helper: NSObject {
    
    class func loadImage(url: String, image: UIImageView){
        
        let urlWithoutEncoding = (url)
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
//        DispatchQueue.global(qos: .userInitiated).async {

        let encodedURL = NSURL(string: encodedLink!)! as URL
        image.kf.indicatorType = .activity
        image.contentMode = .scaleAspectFill
        
        if let url = URL(string: "\(encodedURL)") {
        image.kf.setImage(with: url, placeholder: nil)
            
          //UIImage(named: "")
        }else{
            
//            image.image = #imageLiteral(resourceName: "9")
        }
        
    }
    
    class func restartApp(){
        
    }
}
