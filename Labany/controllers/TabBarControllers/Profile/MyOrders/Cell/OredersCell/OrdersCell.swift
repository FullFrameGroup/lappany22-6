//
//  OrdersCell.swift
//  Labany
//
//  Created by Eman Gaber on 8/1/21.
//

import UIKit

class OrdersCell: UITableViewCell {
    @IBOutlet weak var lblStatus:UILabel!
    @IBOutlet weak var lblOrderNumber:UILabel!
    @IBOutlet weak var lblTotalAmount:UILabel!
    @IBOutlet weak var btnDelete:UIButton!
    @IBOutlet weak var itemsTableView:UITableView!
    @IBOutlet var BottomView: UIView!
    @IBOutlet var topView: UIView!
    var itemsArrr : [CartItems]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTableView()
        BottomView.roundedBottom(rounded: 10)
        topView.roundedTop(rounded: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configuar(MyOrderObjc:OrderModel?){
        itemsArrr = MyOrderObjc?.cart_item
        selectionStyle = .none
        lblStatus.text = MyOrderObjc?.order_status_str
        lblOrderNumber.text = "#"+"\(MyOrderObjc?.o_id! ?? 0)"
        lblTotalAmount.text = "\(MyOrderObjc?.total ?? 0) ريال"
        itemsTableView.reloadData()

    }
    
    
}

extension OrdersCell : UITableViewDelegate,UITableViewDataSource {
    
    
    func setupTableView()
    {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.register(UINib.init(nibName: "CartTableCell", bundle:nil), forCellReuseIdentifier: "cell")
        
        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsArrr?.count ?? 0

    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableCell
        
        let index = itemsArrr?[indexPath.row]
        cell.btndelete.isHidden = true
            cell.configuarMyOrdersCell(cartItem:index)
        var total = 0.0
        let qty = Double((index?.qty)!)
        var final  = 0.0
        for item in itemsArrr ?? []
        {
            total += Double(item.total_price ?? 0)
            final = Double(total * qty)
            cell.lblPrice.text = "\(final) ريال"
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 83
    }
    
    
}
