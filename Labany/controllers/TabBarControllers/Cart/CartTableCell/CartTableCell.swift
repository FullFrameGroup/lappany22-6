//
//  CartTableCell.swift
//  Labany
//
//  Created by Eman Gaber on 6/30/21.
//

import UIKit
import Kingfisher

class CartTableCell: UITableViewCell {
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var viewCalc: UIView!
    @IBOutlet var viewPrice: UIView!
    @IBOutlet var lblBeforeOffer: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var btnPlus: UIButton!
    @IBOutlet var btnminuus: UIButton!
    @IBOutlet var btndelete: UIButton!
    @IBOutlet var lblQuantity: UILabel!
    @IBOutlet var lblItemsumber: UILabel!
    @IBOutlet var bgView: UIView!

    var MyOrdersVC = MyOrdersListVC()
    var quantity = 1
    var cartItem:CartItemsModel?
    var cartVC = CartVC()
    var index = 0
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    @IBAction func plusTapped(_ sender:UIButton){
        btnPlus.tag = sender.tag
        
        quantity = quantity + 1
        lblQuantity.text = "\(quantity)"
        //let totalPriceForCart = ((cartItem?.total_price!)! * quantity)
        print(quantity)
        
        let itemPrice = (Double(cartItem?.size_price ?? 0.0) + Double(cartItem?.cut_price ?? 0.0) + Double(cartItem?.extra_price ?? 0.0) + Double(cartItem?.packing_price ?? 0.0))
       
        let totalPrice = (Int(itemPrice) * quantity)
        lblPrice.text = "\(totalPrice)"
        //lblPrice.text = "\(totalPriceForCart)"
        
        self.cartItem!.qty = quantity
                self.cartItem!.total_price = totalPrice
//        self.cartItem!.total_price = Int(totalPriceForCart)
        cartVC.updateCartItem(cartItem: self.cartItem!, index: self.index)
    }
    
    @IBAction func minusTapped(_ sender:UIButton){
        btnPlus.tag = sender.tag
        if quantity > 1
        {
            quantity = quantity - 1
            lblQuantity.text = "\(quantity)"
            
            let itemPrice = (Double(cartItem?.size_price ?? 0.0) + Double(cartItem?.cut_price ?? 0.0) + Double(cartItem?.extra_price ?? 0.0) + Double(cartItem?.packing_price ?? 0.0))
            let totalPrice = (Int(itemPrice) * quantity)
            
            //let totalPrice = ((cartItem?.qty_price!)! * quantity)
            
            //let totalPriceForCart = ((cartItem?.total_price!)! * quantity)
            
            lblPrice.text = "\(totalPrice)"
         // lblPrice.text = "\(totalPriceForCart)"

            self.cartItem!.qty = quantity
            self.cartItem!.total_price = totalPrice
//            self.cartItem!.total_price = totalPriceForCart
            cartVC.updateCartItem(cartItem: self.cartItem!, index: self.index)

        }
    }
    
    
    func configuarCart(cartItem:CartItemsModel?, index:Int){
        self.cartItem = cartItem
        self.index = index
//        lblBeforeOffer.text! = "\(cartItem?.total_price ?? 0)"
        lblPrice.text! = "\(cartItem?.qty_price ?? 0)"
        let str = "التقطيع " + "\(cartItem?.cut_name ?? "")" + " - " + " الحجم" + ("\(cartItem?.extra_name ?? "")") +  " - "  +  "العدد"  + (" \(cartItem?.qty ?? 0)")
        lblDescription.text = str
        lblProductName.text = "\(cartItem?.product_name ?? "")"
        lblPrice.text! = "\(cartItem?.total_price ?? 0) ريال"
        lblQuantity.text = "\((cartItem?.qty!)!)"
        quantity = (cartItem?.qty!)!
        productImg.sd_setImage(with: URL.init(string:cartItem?.product_image ?? ""))
        let encodedImg = cartItem?.product_image?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
        selectionStyle = .none
    }
    
    
    func configuarMyOrdersCell(cartItem:CartItems?){
       
//        lblBeforeOffer.text! = "\(cartItem?.total_price ?? 0)"
        print("cart item image URL:",cartItem?.product_image)
        productImg.sd_setImage(with: URL.init(string:cartItem?.product_image ?? ""))
        productImg.contentMode = .scaleToFill
        lblPrice.text! = "\(cartItem?.total_price ?? 0)"
        
        
        let str = "التقطيع" + " \(cartItem?.cut_name ?? "") - " + "الحجم" + " \(cartItem?.size_name ?? "") - " + "العدد"  + " \(cartItem?.qty ?? 0)"
        lblDescription.text = str
        lblItemsumber.text = "العدد:\(cartItem?.qty ?? 0)"
        lblProductName.text! = "\(cartItem?.product_name ?? "")"
        viewCalc.isHidden = true
        bgView.backgroundColor = #colorLiteral(red: 0.9466983676, green: 0.9468340278, blue: 0.9347376227, alpha: 1)
        selectionStyle = .none
    }
    
    
}
