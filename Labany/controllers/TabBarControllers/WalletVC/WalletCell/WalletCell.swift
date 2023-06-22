//
//  WalletCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import UIKit

class WalletCell: UITableViewCell {
    @IBOutlet weak var img:UIButton!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var lbldate:UILabel!
    var status:Double?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
//        if MOLHLanguage.isArabic() == false {
            lblDescription.textAlignment = .right
//        }else{
//            lblDescription.textAlignment = .left
//        }
    }
    
    func configCell(wallet:Walletlist){
        lbldate.text = wallet.date_time
        lblDescription.text = wallet.description

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
