//
//  RateOrderCell.swift
//  Labany
//
//  Created by Eman Gaber on 8/5/21.
//

import UIKit

class RateOrderCell: UITableViewCell {

    @IBOutlet weak var btnGood: UIButton!
    @IBOutlet weak var btnBad: UIButton!
    
    @IBOutlet weak var lblGood: UILabel!
    @IBOutlet weak var lblBad: UILabel!
    
    @IBOutlet weak var viewGood: UIView!
    @IBOutlet weak var viewBad: UIView!
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var answer :String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell (Ques:questions){
        lblTitle.text = Ques.title
     
    }
    func selectGood()
    {
        lblGood.textColor  = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
        lblBad.textColor  = .black
      
        viewGood.borderColor  = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
        viewBad.borderColor  = .clear
        
        viewGood.borderWidth  = 1
        viewBad.borderWidth  = 0
    }
    
    func selectBad()
    {
        lblBad.textColor  = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
        lblGood.textColor  = .black
      
        viewBad.borderColor  = #colorLiteral(red: 0.6696161628, green: 0.2250760794, blue: 0.22502473, alpha: 1)
        viewGood.borderColor  = .clear
        
        viewBad.borderWidth  = 1
        viewGood.borderWidth  = 0
    }
    
}
