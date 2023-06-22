//
//  UICollectionView.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 2/27/21.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }
    var collectionView: UICollectionView? {
        return (next as? UICollectionView)
    }
    
  
}

extension UICollectionView {
    func reload(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
    
    func showAnimation() {
        self.reloadData()
        self.layoutIfNeeded()
        self.showLoader()
    }
    
    func hideAnimation() {
        self.hideLoader()
        self.reloadData()
        //        self.layoutIfNeeded()
    }

}
