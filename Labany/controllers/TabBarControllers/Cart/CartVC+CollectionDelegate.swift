//
//  CartVC+CollectionDelegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/18/21.
//

import Foundation
import UIKit
import Presentr

extension CartVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    func setCollection()
    {
        visaCollection.register(UINib(nibName: "VisaCell", bundle: nil), forCellWithReuseIdentifier: "VisaCell")
        visaCollection.delegate = self
        visaCollection.dataSource = self


    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartVM.visaArr?.count ?? 0

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VisaCell", for: indexPath) as! VisaCell
        let index = cartVM.visaArr?[indexPath.row]
        cell.configCell(visa:index)
        //cell.transform = CGAffineTransform(scaleX: -1, y: 1)

        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76 , height: 42)
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if self.selectAddress == ""
//        {
//         showMessage(msg: "اختر عنوان التوصيل", type: .notification)
//        }else if selectedDate == "" || selectedDate == nil{
//         showMessage(msg: "اختر تاريخ التوصيل", type: .notification)
//        }else if selectedTime == "" || selectedTime == nil{
//        showMessage(msg: "اختر ووقت التوصيل", type: .notification)
//
//        }else
        let type = cartVM.visaArr?[indexPath.row].visa_type_name
        cash = false
        switch type {
        case "فيزا":
            requestCheckoutID(type:"VISA")
        case "مدى":
            requestCheckoutID(type:"MADA")
        default:
            break
        }
//        if indexPath.row == 0{
//            // VISA
//            cash = false
//            requestCheckoutID(type:"VISA")
//        }else  if indexPath.row == 1
//        {
//            cash = false
//            //  STC_PAY
//            requestCheckoutID(type:"STC_PAY")
//        }else  if indexPath.row == 2
//
//        {
//            cash = false
//            // MADA
//            requestCheckoutID(type:"MADA")
//
//        }
    }
}

