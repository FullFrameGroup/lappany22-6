////
////  StandardTextFieldView.swift
////  EmiratesParking
////
////  Created by sameh on 8/17/20.
////  Copyright © 2020 mongy. All rights reserved.
////
//
//import UIKit
//
//protocol StandardTextFieldViewProtocol: AnyObject {
//    func didBeginEditing(_ textField: StandardTextFieldView)
//    func didEndEditing(_ textField: StandardTextFieldView)
//    func textFieldShouldReturn(_ textField: StandardTextFieldView)
//    func didChangeText(text: String, _ textField: StandardTextFieldView)
//}
//
//class StandardTextFieldView: UIView {
//
//    //Outlets
//    @IBOutlet weak var contentView: UIView!
//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var textFieldViewContainer: UIView!
//    @IBOutlet weak var errorLabel: UILabel!
//    @IBOutlet weak var errorViewContainer: UIView!
//    @IBOutlet weak var showHidePasswordButton: UIButton!
//    @IBOutlet weak var clearButton: UIButton!
//    @IBOutlet weak var floatingTitleLabel: UILabel!
//    @IBOutlet weak var topConstraint: NSLayoutConstraint!
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
//    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
//    
//    
//    weak var delegate: StandardTextFieldViewProtocol?
//    private var maxChars: Int?
//    var unAllowedChars: [String] = []
//    private var isPasswordField = false
//    private var isSecureEntry: Bool = false {
//        didSet {
//            updateIsSecureEntry(with: isSecureEntry)
//        }
//    }
//    private let images = Images()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        nibSetup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        nibSetup()
//    }
//
//    private func nibSetup() {
//        Bundle.main.loadNibNamed("\(StandardTextFieldView.self)",
//                                 owner: self, options: nil)
//        guard let contentView = contentView else { return }
//        contentView.frame = self.bounds
//        addSubview(contentView)
//    }
//}
//
////MARK: - UI Setup
//extension StandardTextFieldView {
//    
//    func setupUI(isPasswordField: Bool, placeholder: String, nextButton: Bool) {
//        self.isPasswordField = isPasswordField
//        if isPasswordField {
//            setupPasswordField()
//        } else {
//            setupNormalField()
//        }
//        setupReturnKey(nextButton)
//        setupErrorLabel()
//        setupTextField(placeholder: placeholder)
//    }
//    
//    func setupSpacing(insets: UIEdgeInsets) {
//        leadingConstraint.constant = insets.left
//        trailingConstraint.constant = insets.right
//        topConstraint.constant = insets.top
//        bottomConstraint.constant = insets.bottom
//        layoutIfNeeded()
//    }
//    
//    func setupFloatingTitle(with text: String) {
//        floatingTitleLabel.text = text
//        floatingTitleLabel.isHidden = false
//        floatingTitleLabel.textColor = .purplishBrown
//        floatingTitleLabel.font = UIFont.get(enFont: .regular(16), arFont: .regular(16))
//    }
//    
//    private func setupPasswordField() {
//        isSecureEntry = true
//        showHidePasswordButton.isHidden = false
//        showHidePasswordButton.isHidden = false
//        clearButton.isHidden = true
//    }
//    
//    private func setupNormalField() {
//        isSecureEntry = false
//        showHidePasswordButton.isHidden = true
//        showHidePasswordButton.isHidden = true
//        clearButton.isHidden = true
//    }
//    
//    private func setupTextField(placeholder: String) {
//        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
//                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueGrey, NSAttributedString.Key.font: UIFont.get(enFont: .regular(16), arFont: .regular(16))])
//        textField.textColor = .purplishBrown
//        textField.tintColor = .purplishBrown
//        textField.font = UIFont.get(enFont: .regular(16), arFont: .regular(16))
//        textField.delegate = self
//    }
//    
//    private func setupReturnKey(_ nextButton: Bool) {
//        textField.returnKeyType = nextButton ? .next : .done
//    }
//    
//    private func updateIsSecureEntry(with value: Bool) {
//        textField.isSecureTextEntry = value
//        let image = value ? UIImage(named: images.normalEye) : UIImage(named: images.dashedEye)
//        showHidePasswordButton.setImage(image, for: .normal)
//    }
//    
//    private func setupErrorLabel() {
//        errorLabel.font = UIFont.get(enFont: .regular(14), arFont: .regular(14))
//        errorLabel.textColor = .coral
//    }
//    
//    func displayError(_ errorMessage: String) {
//        errorLabel.isHidden = false
//        errorLabel.text = errorMessage
//        errorViewContainer.isHidden = false
//        textFieldViewContainer.layer.borderWidth = 1
//        textFieldViewContainer.layer.borderColor = UIColor.coral.cgColor
//    }
//    
//    func removeErrorView() {
//        errorLabel.isHidden = true
//        errorViewContainer.isHidden = true
//        textFieldViewContainer.layer.borderColor = UIColor.lightGreyGreen.cgColor
//    }
//    
//    func requestFocus() {
//        textField.becomeFirstResponder()
//    }
//    
//    func releaseFocus() {
//        textField.resignFirstResponder()
//    }
//}
//
//// MARK: - UITextFieldDelegate
//extension StandardTextFieldView: UITextFieldDelegate {
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        delegate?.didBeginEditing(self)
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        delegate?.didEndEditing(self)
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        delegate?.textFieldShouldReturn(self)
//        clearButton.isHidden = true
//        return true
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        if !unAllowedChars.isEmpty {
//            let set = CharacterSet(charactersIn: unAllowedChars.joined())
//            let inverted = set.inverted
//            let filtered = string.components(separatedBy: inverted).joined(separator: "")
//            if filtered.isEmpty && string.isEmpty {
//                return true
//            }
//            if filtered != string {
//                if let maxLength = maxChars {
//                    let currentString: NSString = textField.text! as NSString
//                    let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//                    return newString.length <= maxLength
//                }
//            }
//            return false
//        }
//        
//        return true
//    }
//    
//    @IBAction func didChangeText(_ sender: Any) {
//        delegate?.didChangeText(text: inputText, self)
//        if !isPasswordField {
//            clearButton.isHidden = !(textField.text?.count ?? 0 > 0)
//        }
//    }
//
//}
//
//// MARK: - IBActions
//extension StandardTextFieldView {
//    @IBAction func showHidePasswordDidTapped(_ sender: Any) {
//        isSecureEntry = !isSecureEntry
//    }
//    
//    @IBAction func clearTextField(_ sender: Any) {
//        if !isSecureEntry {
//            textField.text = ""
//            clearButton.isHidden = true
//        }
//    }
//}
//
//extension StandardTextFieldView {
//    
//    func addMaxCharToTextField(_ maxChars: Int) {
//        self.maxChars = maxChars
//    }
//    
//}
//
//// MARK: - Input Text
//extension StandardTextFieldView {
//    var inputText: String {
//        textField.text ?? ""
//    }
//}
//
//// MARK: - Images
//extension StandardTextFieldView {
//    struct Images {
//        let normalEye = "common_open_eye_ic"
//        let dashedEye = "common_dashed_eye_ic"
//    }
//}
