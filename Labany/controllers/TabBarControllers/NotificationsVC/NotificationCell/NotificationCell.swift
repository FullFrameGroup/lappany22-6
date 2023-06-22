//
//  NotificationCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/10/21.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet var lblDescrription: UILabel!
    @IBOutlet var lbltime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(notifiy:Notifications?)
    {
        lbltime.text = notifiy?.notificationDate
        lblDescrription.text = notifiy?.notification
//        lblTitle.text = category?.categoryName
//        self.category = category
//        homecollection.reloadData()
    }
}
