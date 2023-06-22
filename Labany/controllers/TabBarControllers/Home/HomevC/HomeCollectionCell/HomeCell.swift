//
//  HomeCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/9/21.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius  = 15
        
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        
        
    }
    
    func configCell(product:ProductModel?)
    {
//        lblTitile.text = product?.productName ?? "" //urdo
        
        let encodedImg = product?.productImage?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""

        img.sd_setImage(with: URL.init(string:encodedImg), placeholderImage: #imageLiteral(resourceName: "Mask Group 8")) { (image, error, cache, url) in
            self.img.contentMode = .scaleAspectFit
            self.img.clipsToBounds = true
            self.img.layer.cornerRadius = 15
            
        }
        
        
    }

}
