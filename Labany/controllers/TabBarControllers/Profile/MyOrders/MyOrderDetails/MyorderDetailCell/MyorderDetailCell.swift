//
//  MyorderDetailCell.swift
//  Labany
//
//  Created by Eman Gaber on 8/2/21.
//

import UIKit

class MyorderDetailCell: UITableViewCell {

    @IBOutlet var lblPRice: UILabel!
    @IBOutlet var lblquantity: UILabel!
    @IBOutlet var lblRange: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.roundedBottom(rounded: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configCell(orderObjc:CartItems?){
        selectionStyle = .none
        lblName.text = orderObjc?.product_name
        lblquantity.text = "\(orderObjc?.qty ?? 0)"
        lblDescription.text! = " التقطيع " + ("\(orderObjc?.cut_name ?? "")") + "\n" + " الحجم " +  ("\(orderObjc?.extra_name ?? "")") +  "\n" + " العدد  "  + ("\(orderObjc?.qty ?? 0)")
        lblPRice.text = "\(orderObjc?.total_price ?? 0)" + " ريال" 
    }
}
