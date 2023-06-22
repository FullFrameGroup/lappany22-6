//
//  AddressCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/17/21.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet var btnEdite: UIButton!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet weak var stackV: UIStackView!
    @IBOutlet var lblCityName: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblareaName: UILabel!
    @IBOutlet weak var lbluserName: UILabel!
    @IBOutlet weak var lblPhoneNum: UILabel!

    @IBOutlet weak var Bgview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        selectionStyle = .none
        viewHeader.clipsToBounds = true
        viewHeader.layer.cornerRadius = 10
        viewHeader.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        stackV.clipsToBounds = true
        stackV.layer.cornerRadius = 10
        stackV.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        setUp()
        
    }
    
    
    func setUp() {
        Bgview.addShadow(color: .lightGray)
    }
    
    func configcell(address:shippingArrressList){
        lblCityName.text = address.city_arabic
        lblareaName.text = address.district_name
        lbluserName.text = address.alter_name
        lblPhoneNum.text = address.alter_contact
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
