//
//  UICollectionView.swift
//  Drovox Passenger
//
//  Created by Eman Gaber on 2/27/21.
//

import Foundation
import UIKit
//import ListPlaceholder


extension UITableView {
    func reload(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
    
    func showAnimation() {
        self.reloadData()
        self.showLoader()
    }
    
    func hideAnimation() {
        self.hideLoader()
    }

}
