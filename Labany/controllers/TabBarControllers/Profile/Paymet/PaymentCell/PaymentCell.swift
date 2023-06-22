//
//  PaymentCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var imgVisa: UIImageView!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblCarDNum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        bgview.addBottomShadowImage(parentview: bgview, shadowColor: .lightGray)
        btnDelete.addBottomShadowImage(parentview: btnDelete, shadowColor: .lightGray)
        imgVisa.addBottomShadowImage(parentview: imgVisa, shadowColor: .lightGray)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func Configure(visa:VisaModel?){
        lblCarDNum.text = "\(visa?.card_number ?? "")"
        imgVisa.sd_setImage(with: URL.init(string:visa?.visa_type_img ?? ""))
    }
    
}
