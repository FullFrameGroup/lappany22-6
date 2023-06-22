//
//  VisaCell.swift
//  Labany
//
//  Created by Eman Gaber on 8/3/21.
//

import UIKit

class VisaCardCell: UITableViewCell {
    @IBOutlet var lblCarDNum: UILabel!
    @IBOutlet var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func Configure(visa:VisaModel?){
        
        lblCarDNum.text = visa?.card_number
        img.sd_setImage(with: URL.init(string:visa?.visa_type_img ?? ""))
    }
    
}
