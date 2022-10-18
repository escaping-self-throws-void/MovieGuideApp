//
//  SignUpTableViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit
import CountryPickerView

enum SUCellStyle {
    case email
    case password
    case confirm
    case birthday
    case gender
    case country
    case signUp
    case logIn
    case logInPassword
}

final class SignUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bigSignUpButton: UIButton!
    @IBOutlet weak var signUpCellLabel: UILabel!
    @IBOutlet weak var signUpCellTextField: UITextField!
    @IBOutlet weak var signUpCellButton: UIButton!
    @IBOutlet weak var errorCellLabel: UILabel!
    
    lazy var cpv: CountryPickerView = {
        CountryPickerView()
    }()
    var style: SUCellStyle = .email
    var isSecure = true
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        dp.minimumDate = Calendar.current.date(byAdding: .year, value: -118, to: Date())
        dp.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        dp.addTarget(self, action: #selector(dateChange(_:)), for: UIControl.Event.valueChanged)
        return dp
    }()
    
    private lazy var genderPicker: UIPickerView = {
        let gp = UIPickerView()
        return gp
    }()
    private let genders = [C.Genders.male, C.Genders.female]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setupStyle()
    }
     
    func showError(_ on: Bool) {
        signUpCellTextField.layer.borderColor = on
        ? (UIColor(named: C.Colors.dustyRed) ?? .red).cgColor
        : (UIColor(named: C.Colors.brownishGreyTwo) ?? .black).cgColor
        signUpCellLabel.textColor = on
        ? UIColor(named: C.Colors.dustyRed)
        : UIColor(named: C.Colors.brownishGreyTwo)
        errorCellLabel.isHidden = !on
    }
    
    private func setupUI() {
        backgroundColor = .clear
        signUpCellTextField.textAlignment = .defaultAlignment
        signUpCellTextField.layer.cornerRadius = 4
        signUpCellTextField.layer.borderWidth = 1
        signUpCellTextField.layer.borderColor = (UIColor(named: C.Colors.brownishGreyTwo) ?? .black).cgColor
    }
    
    private func setupStyle() {
        switch style {
        case .email:

            areHidden(signUpCellLabel, signUpCellTextField, on: false)
        case .password:

            signUpCellTextField.isSecureTextEntry = isSecure

        case .confirm:
 
            signUpCellTextField.isSecureTextEntry = isSecure

        case .birthday:
            signUpCellTextField.placeholder = C.LocKeys.sUBirthdayPlaceholder.localized()
            signUpCellButton.setImage(UIImage(named: C.Images.calendar), for: .normal)
            signUpCellTextField.inputView = datePicker
            areHidden(signUpCellTextField, signUpCellButton, on: false)
        case .gender:
            signUpCellTextField.placeholder = C.LocKeys.sUGenderPlaceholder.localized()
            signUpCellButton.setImage(UIImage(named: C.Images.disclosure), for: .normal)
            setupGenderPicker()
            areHidden(signUpCellTextField, signUpCellButton, on: false)
        case .country:
            signUpCellTextField.placeholder = C.LocKeys.sUCountryPlaceholder.localized()
            signUpCellButton.setImage(UIImage(named: C.Images.disclosure), for: .normal)
            cpv.delegate = self
            areHidden(signUpCellTextField, signUpCellButton, on: false)
        case .signUp:
            bigSignUpButton.setTitle(C.LocKeys.sUBigButtonLbl.localized(), for: .normal)
            bigSignUpButton.isHidden = false
            bigSignUpButton.isEnabled = false
            bigSignUpButton.alpha = 0.5
        case .logIn:
            bigSignUpButton.setTitle(C.LocKeys.sUBigButtonLogInLbl.localized(), for: .normal)
            bigSignUpButton.isHidden = false
            bigSignUpButton.isEnabled = false
            bigSignUpButton.alpha = 0.5
        case .logInPassword:
            signUpCellLabel.text = C.LocKeys.sUPasswordCellLbl.localized()
            signUpCellTextField.placeholder = C.LocKeys.sUPasswordPlaceholder.localized()
            signUpCellTextField.autocapitalizationType = .none
            signUpCellTextField.autocorrectionType = .no
            signUpCellButton.setTitle(C.LocKeys.sUForgotButton.localized(), for: .normal)
            signUpCellButton.setTitleColor(.white, for: .normal)
            signUpCellButton.titleLabel?.font = UIFont(name: C.Fonts.almaraiBold, size: 13)
            areHidden(signUpCellTextField, signUpCellButton, on: false)
        }
        
    }
    
    private func areHidden(_ view: UIView..., on: Bool) {
        view.forEach { $0.isHidden = on }
    }
    
    @objc private func dateChange(_ datePicker: UIDatePicker) {
        signUpCellTextField.text = datePicker.date.birthdayText
    }
}

// MARK: - CountryPickerViewDelegate methods

extension SignUpTableViewCell: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        signUpCellTextField.text = country.name
    }
}

// MARK: - UIPickerView Delegate and DataSource methods

extension SignUpTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        signUpCellTextField.text = genders[row]
    }
    
    @objc func doneButtonTapped() {
        let selectedRow = genderPicker.selectedRow(inComponent: 0)
        signUpCellTextField.text = genders[selectedRow]
    }
    
    private func setupGenderPicker() {
        genderPicker.delegate = self
        genderPicker.dataSource = self
//        signUpCellTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonTapped))
        signUpCellTextField.inputView = genderPicker
    }
}
