//
//  VisaCell.swift
//  Labany
//
//  Created by Eman Gaber on 7/18/21.
//

import UIKit

class VisaCell: UICollectionViewCell {
    
    @IBOutlet weak var img :UIImageView!
    @IBOutlet weak var bgView :UIView!
    @IBOutlet weak var lblCash :UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius  = 13
        
    }
    
    func configCell(visa:VisaTypeModel?)
    {
        let encodedImg = visa?.visa_type_img?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
//
//        img.sd_setImage(with: URL.init(string:encodedImg), placeholderImage: #imageLiteral(resourceName: "social_color_1_logo_paypal")) { (image, error, cache, url) in
//        }
        Helper.loadImage(url:encodedImg , image: self.img)
        self.img.contentMode = .scaleAspectFit
       
    }
}
