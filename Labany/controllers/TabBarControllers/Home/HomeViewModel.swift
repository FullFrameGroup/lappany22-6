//
//  HomeViewModel.swift
//  Labany
//
//  Created by Eman Gaber on 7/14/21.
//

import Foundation
import PKHUD
import Alamofire
//import SwiftyJSON
import MIAlertController
import SDWebImage
import ImageSlideshow

protocol HomeViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showErrorAlert(error:String)
    func fetchHomeDataSuccessfully()
    func setupSlideShow(inputSources:[InputSource])
   
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    init(delegate:HomeViewModelDelegate?) {
        self.delegate = delegate
    }
    var homeData:HomeDataModel?
    var categoriesArr:[CategoryModel]?
    var productArr = [CategoryModel]()
    var sliderImages = [BannerModel]()
    let slideshow = ImageSlideshow()
    
    func getHomeCategories(cityId:Int) {
        self.delegate?.showLoading()
        HomeWebServices.getHomeCategoriesApi(cityId:cityId ){ [self] (data, error) in
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
           //phoneRegister succ
        homeData = data?.data
        
        var categories:[CategoryModel] = []
        for cat in data?.data?.categories ?? []
        {
            if cat.products?.count ?? 0 != 0
            {
                categories.append(cat)
            }
        }
        
        homeData?.categories = categories
        
        
        self.sliderImages = homeData?.banners ?? []
      
        var imagesInputSources = [InputSource]()
        for sliderModel in self.sliderImages{
            
            let imageEndPoint = sliderModel.bannerimage
            
            if let imageUrl = URL(string: imageEndPoint ?? "") {
                imagesInputSources.append(SDWebImageSource(url: imageUrl))
            }
            self.delegate?.setupSlideShow(inputSources: imagesInputSources)
        }
//        self.delegate?.setupSlideShow(inputSources: imagesInputSources)

           self.delegate?.fetchHomeDataSuccessfully()
       }
   }

}

}
