//
//  ProductDetails.swift
//  Labany
//
//  Created by Eman Gaber on 5/18/21.
//

import UIKit
import DropDown
import TransitionButton
import LSDialogViewController

class ProductDetailsVC: UIViewController {
    
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var finalPrice: UILabel!
    @IBOutlet var tfNotes: UITextField!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var btnCuttinng: UIButton!
    @IBOutlet var btnSize: UIButton!
    @IBOutlet var btnNumbers: UIButton!
    @IBOutlet var btnPackaging: UIButton!
    @IBOutlet var btnExtra: UIButton!
    
    var productDetailVM:ProductDetailViewModel!
    var delegate: HomeVC?
    
    let extraMenue = DropDown()
    let cuttingMenue = DropDown()
    let sizeMenue = DropDown()
    let packagingMenue = DropDown()
    
    var cuttNamesArray = [String]()
    var selectedCuttId = -1
    var extraNamesArray = [String]()
    var selectedExtraId = -1
    var packageNamesArray = [String]()
    var selectedPackageId = -1
    var sizeNamesArray = [String]()
    var selectedSizeId = -1
    var extraArr:[ExtraModel]?
    var packageArr:[PackingModel]?
    var sizeArr:[SizeModel]?
    var cuttArr:[CutModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
     //   productDetailVM = ProductDetailViewModel(delegate: self)

        
            extraMenue.langNum = "1"
            extraMenue.isTransform = true
            
            sizeMenue.langNum = "1"
            sizeMenue.isTransform = true
            
            cuttingMenue.langNum = "1"
            cuttingMenue.isTransform = true
            
            packagingMenue.langNum = "1"
            packagingMenue.isTransform = true
        
        
        setUpCuttingDropDown()
        setUpSizeDropDown()
        setUpExtreDropDown()
        setUpPackagingDropDown()
        setupDropdownView()
        
        // adjust height and width of dialog
        view.bounds.size.height = (UIScreen.main.bounds.size.height * 0.5)  - 60
        view.bounds.size.width = UIScreen.main.bounds.size.width * 0.8
        view.layer.cornerRadius = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addToCartAction(_ sender: Any) {
    }
    
    @IBAction func extraBtAction(_ sender: UIButton) {
        extraMenue.show()
    }
    
    @IBAction func packageBtAction(_ sender: UIButton) {
        packagingMenue.show()
    }
        @IBAction func cuttingBtnAction(_ sender: UIButton) {
            
            cuttingMenue.show()
        }
    
    @IBAction func sizeBtnAction(_ sender: UIButton) {
        
        sizeMenue.show()
    }


    

    
    
    
    
    
    @IBAction func closeButton(_ sender: AnyObject) {
//        delegate?.dismissDialog()
    }
    
    
    
    func setUpCuttingDropDown()
    {
        cuttingMenue.anchorView = btnCuttinng
        
        cuttingMenue.bottomOffset = CGPoint(x: 0, y: btnCuttinng.frame.size.height) //6
        
//
        cuttingMenue.direction  = .bottom
        cuttingMenue.backgroundColor = .white
        cuttingMenue.addShadow(color: .lightText)
        cuttingMenue.layer.cornerRadius = 10
        cuttingMenue.animationEntranceOptions = .transitionCurlUp
        
        cuttingMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            
            self?.btnCuttinng.setTitle(item, for: .normal)
        }
    }
    
    func setUpSizeDropDown()
    {
        sizeMenue.anchorView = btnCuttinng
        sizeMenue.bottomOffset = CGPoint(x: 0, y: btnSize.frame.size.height) //6
        sizeMenue.direction  = .bottom
        sizeMenue.backgroundColor = .white
        sizeMenue.addShadow(color: .lightText)
        sizeMenue.layer.cornerRadius = 10
        sizeMenue.animationEntranceOptions = .curveEaseInOut

        sizeMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }

            self?.btnSize.setTitle(item, for: .normal)
        }
    }

    func setUpExtreDropDown()
    {
        extraMenue.anchorView = btnExtra
        extraMenue.bottomOffset = CGPoint(x: 0, y: btnExtra.frame.size.height) //6
        extraMenue.direction  = .bottom
        extraMenue.backgroundColor = .white
        extraMenue.addShadow(color: .lightText)
        extraMenue.layer.cornerRadius = 10
        extraMenue.animationEntranceOptions = .curveEaseOut

        extraMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }

            self?.btnExtra.setTitle(item, for: .normal)
        }
    }

    func setUpPackagingDropDown()
    {
        packagingMenue.anchorView = btnPackaging
        packagingMenue.bottomOffset = CGPoint(x: 0, y: btnPackaging.frame.size.height) //6
        packagingMenue.direction  = .bottom
        packagingMenue.backgroundColor = .white
        packagingMenue.addShadow(color: .lightText)
        packagingMenue.layer.cornerRadius = 10
        packagingMenue.animationEntranceOptions = .beginFromCurrentState

        packagingMenue.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }

            self?.btnPackaging.setTitle(item, for: .normal)
        }
    }
    
    func setupDropdownView(){
      
    }
    
    
    func loadExtraMenu()
    {
        var names : [String] = []
        for extra in extraArr ?? []
        {
            names.append(extra.extra_type ?? "")

        }
        extraMenue.dataSource = names
        extraNamesArray = names
    }
    
    func loadCuttMenu()
    {
        var names : [String] = []
        for cutt in cuttArr ?? []
        {
            names.append(cutt.cut_piece_type ?? "")
            
        }
        cuttingMenue.dataSource = names
        cuttNamesArray = names
    }
    
    func loadSizeMenu()
    {
        var names : [String] = []
        for size in sizeArr ?? []
        {
            names.append(size.size_type ?? "")

        }
        sizeMenue.dataSource = names
        sizeNamesArray = names
    }


    func loadPackagingMenu()
    {
        var names : [String] = []
        for package in packageArr ?? []
        {
            names.append(package.packing_type ?? "")

        }
        packagingMenue.dataSource = names
        packageNamesArray = names
    }

}

