//
//  ProfileCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/11/21.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = UIFont(name:"Tajawal-Bold",size:15)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
