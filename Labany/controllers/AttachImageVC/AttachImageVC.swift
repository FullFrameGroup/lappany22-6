//
//  AttachImageVC.swift
//  Madinaty
//
//  Created by MacOS on 4/17/20.
//  Copyright © 2020 Eman Gaber. All rights reserved.
//

import UIKit


public protocol AttachImageDelegate: AnyObject {
    func didSelect(image: UIImage?)
    
}


class AttachImageVC: UIViewController {
    
    weak var delegate: AttachImageDelegate?
    
    @IBOutlet weak var vievBg: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        vievBg.layer.cornerRadius = 8
        lblTitle.text = "إضافة صورة"
        
//            btnGallery.contentHorizontalAlignment = .right
//            btnCamera.contentHorizontalAlignment = .right
        
    }
    
    
    @IBAction func CloseAction(_ sender: Any) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    func CloseAlert(){
        self.dismiss(animated: true, completion: nil)
//        self.willMove(toParent: nil)
//        self.view.removeFromSuperview()
//        self.removeFromParent()
    }
    
    
    @IBAction func OpenCamera(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    @IBAction func OpenGalary(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    
}

extension AttachImageVC: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true) {() -> Void in
            self.CloseAlert()
        }
        
        
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            
            (self.delegate?.didSelect(image: nil))!
            picker.dismiss(animated: true) {() -> Void in}
            CloseAlert()
            return
        }
        
        (self.delegate?.didSelect(image: image))!
        picker.dismiss(animated: true) {() -> Void in}
        
        CloseAlert()
        return
    }
}

extension AttachImageVC: UINavigationControllerDelegate {
    
}
