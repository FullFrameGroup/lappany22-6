//
//  ComplaintsCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import UIKit

class ComplaintsCell: UITableViewCell {

    @IBOutlet var lblDescrription: UILabel!
    @IBOutlet var lbltime: UILabel!
    @IBOutlet var lblComplaintNum: UILabel!
    @IBOutlet var lblTitle: UILabel!

    @IBOutlet var lblMsg: UILabel!
    @IBOutlet var dottView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
//        bgView.addShadow(color:#colorLiteral(red: 0.9466983676, green: 0.9468340278, blue: 0.9347376227, alpha: 1))
        bgView.addShadowImage(parentview: bgView, shadowColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        topView.roundedTop(rounded: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(complaint:ComplaitsList?)
    {
        lbltime.text = complaint?.complaint_date
        lblDescrription.text = complaint?.complaint_description
        lblTitle.text = complaint?.complaint_title
        lblComplaintNum.text = "#رقم الطلب" + "\(complaint?.complaint_number)"
    }
}

