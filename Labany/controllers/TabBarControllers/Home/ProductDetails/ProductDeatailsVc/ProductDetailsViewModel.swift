//
//  ProductDetailsViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/25/21.
//

import Foundation
protocol ProductDetailViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func fetchExtraDataSuccessfully(extra:[ExtraModel])
    func fetchpackingDataSuccessfully(packige:[PackingModel])
    func fetchSizeDataSuccessfully(size:[SizeModel])
    func fetchCuttingDataSuccessfully(cutPices:[CutModel])
   func addTocartSuccessfully()
    func fetchdataSuccessfully(product:[ProductDetailsModel]?)
}

class ProductDetailViewModel {
    weak var delegate: ProductDetailViewModelDelegate?
    init(delegate:ProductDetailViewModelDelegate?) {
        self.delegate = delegate
    }
    var productDetails:[ProductDetailsModel]?
    var extraArr:[ExtraModel]?
    var packageArr:[PackingModel]?
    var sizeArr:[SizeModel]?
    var cutArr:[CutModel]?

    func getProductDetailsApi(cityId:Int,productId:Int) {
        self.delegate?.showLoading()
        PdoductDetailsWebServices.ProductDetailsApi(cityId:cityId,productId: productId){ [self] (data, error) in
   self.delegate?.killLoading()
   
            if error == nil && data == nil {
                print("Connection failed")
                self.delegate?.connectionFailed()

            } else if (error != nil)  {
                
               self.delegate?.showErrorAlert(error: error ?? "")
                
            } else if (data?.success == false){
            self.delegate?.showErrorAlert(error: data?.msg ?? "")
                
            }
                else if (data?.success == true){

           //Response succ
        
        cutArr = data?.data?.product_detail?.first?.cut_piece
        extraArr = data?.data?.product_detail?.first?.extra
        sizeArr = data?.data?.product_detail?.first?.size
        packageArr = data?.data?.product_detail?.first?.packing
        productDetails = data?.data?.product_detail
        
    self.delegate?.fetchExtraDataSuccessfully(extra:extraArr ?? [])
        self.delegate?.fetchCuttingDataSuccessfully(cutPices: cutArr ?? [])
        self.delegate?.fetchSizeDataSuccessfully(size: sizeArr ?? [] )
        self.delegate?.fetchpackingDataSuccessfully(packige: packageArr ?? [])
                    
    self.delegate?.fetchdataSuccessfully(product: productDetails ?? [])
        
        
       }
   }

}
    
    func callAddToCartApi(parameters: [String : Any],user_id:Int) {
        self.delegate?.showLoading()
        let presenter = PdoductDetailsWebServices()

        presenter.addToCartApi(user_id: user_id, parameters: parameters){ [self] (data, error) in
       self.delegate?.killLoading()
       
       if error == nil && data == nil {
           print("Connection failed")
           self.delegate?.connectionFailed()

       } else if (error != nil)  {
           
        self.delegate?.showErrorAlert(error: error!)
           
       }else {
      
        self.delegate?.addTocartSuccessfully()
   }
        }
        
    }
    

}
