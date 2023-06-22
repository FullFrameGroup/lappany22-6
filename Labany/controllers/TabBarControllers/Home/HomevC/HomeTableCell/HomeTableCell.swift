//
//  HomeTableCell.swift
//  Labany
//
//  Created by Eman Gaber on 5/18/21.
//

import UIKit
import LSDialogViewController

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var homecollection: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    var category:CategoryModel?
    var homeVC = HomeVC()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        setCollection()
    }

    func configCell(category:CategoryModel?)
    {
        lblTitle.text = category?.categoryName
        self.category = category
        homecollection.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}

extension HomeTableCell : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
 
    func setCollection()
    {
        homecollection.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        homecollection.delegate = self
        homecollection.dataSource = self
//        homecollection.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.configCell(product:self.category?.products?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: 150)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeVC.openDetails(productId:(self.category?.products?[indexPath.row].productId!)!, productName: (self.category?.products?[indexPath.row].productName!)!, ProductTypeId: (self.category?.products?[indexPath.row].product_type!)!, img: (self.category?.products?[indexPath.row].productImage!)!)
        
    }

    
}
