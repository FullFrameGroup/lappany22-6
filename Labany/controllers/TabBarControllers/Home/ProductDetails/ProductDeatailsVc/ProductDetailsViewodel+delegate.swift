//
//  ProductDetailsViewodel+delegate.swift
//  Labany
//
//  Created by Eman Gaber on 7/25/21.
//

import Foundation
import UIKit
import PKHUD

extension ProductDetailVC : ProductDetailViewModelDelegate{
    func fetchdataSuccessfully(product: [ProductDetailsModel]?) {
       
        sizePrice = Double(product?.first?.size?.first?.size_price ??  0)
        cutPrice = Double(product?.first?.cut_piece?.first?.cut_piece_price ?? 0)
        packagingPrice = Double(product?.first?.packing?.first?.packing_price ?? 0)

      let encodedImg = product?.first?.productLogo!.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""

        imgLogo.sd_setImage(with: URL.init(string:encodedImg), placeholderImage: #imageLiteral(resourceName: "Mask Group 8")) { (image, error, cache, url) in
//            self.imgLogo.contentMode = .scaleAspectFit
            self.imgLogo.backgroundColor = .white
        }
        
    }
        
    func addTocartSuccessfully(){
        showMessage(msg: "تم اضافة المنتج للسلة بنجاح", type: .success)
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    
    func connectionFailed() {
        self.connectionFailedAlert()
        
    }
    
    func fetchExtraDataSuccessfully(extra: [ExtraModel]) {
        extraArr = extra
        loadExtraMenu()
    }
   
    
    func fetchpackingDataSuccessfully(packige: [PackingModel]) {
        packageArr = packige
        loadPackagingMenu()
        
    }
    
    func fetchSizeDataSuccessfully(size: [SizeModel]) {
        sizeArr = size
        loadSizeMenu()
    }
    
    func fetchCuttingDataSuccessfully(cutPices: [CutModel]) {
        cuttArr = cutPices
        loadCuttMenu()
    }
    func showErrorAlert(error: String) {
        showErrorAlert(message: error)

    }

}

