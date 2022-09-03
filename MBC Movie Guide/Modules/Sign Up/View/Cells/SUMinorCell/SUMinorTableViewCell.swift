//
//  SUMinorTableViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 08/07/2022.
//

import UIKit

enum SUMinorCellStyle {
    case name
    case termsCheck
    case privacyAndTerms
}

final class SUMinorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cNameLabel: UILabel!
    @IBOutlet weak var cLastNameLabel: UILabel!
    @IBOutlet weak var cNameTextField: UITextField!
    @IBOutlet weak var cNameErrorLabel: UILabel!
    @IBOutlet weak var cLastNameTextField: UITextField!
    @IBOutlet weak var cLastNameErrorLabel: UILabel!
    
    @IBOutlet weak var termsCheck: UIButton!
    @IBOutlet weak var adsCheck: UIButton!
    @IBOutlet weak var acceptTermsButton: UIButton!
    @IBOutlet weak var recieveAdsLabel: UILabel!
    
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    
    var style: SUMinorCellStyle = .name
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setupStyle()
    }
    
    func showNameError(_ on: Bool) {
        cNameTextField.layer.borderColor = on
        ? (UIColor(named: C.Colors.dustyRed) ?? .red).cgColor
        : (UIColor(named: C.Colors.brownishGreyTwo) ?? .black).cgColor
        cNameLabel.textColor = on
        ? UIColor(named: C.Colors.dustyRed)
        : UIColor(named: C.Colors.brownishGreyTwo)
        cNameErrorLabel.isHidden = !on
    }
    
    func showLastNameError(_ on: Bool) {
        cLastNameTextField.layer.borderColor = on
        ? (UIColor(named: C.Colors.dustyRed) ?? .red).cgColor
        : (UIColor(named: C.Colors.brownishGreyTwo) ?? .black).cgColor
        cLastNameLabel.textColor = on
        ? UIColor(named: C.Colors.dustyRed)
        : UIColor(named: C.Colors.brownishGreyTwo)
        cLastNameErrorLabel.isHidden = !on
    }

    private func setupUI() {
        cNameTextField.textAlignment = .defaultAlignment
        cLastNameTextField.textAlignment = .defaultAlignment
        backgroundColor = .clear
        cNameTextField.layer.cornerRadius = 4
        cNameTextField.layer.borderWidth = 1
        cNameTextField.layer.borderColor = (UIColor(named: C.Colors.brownishGreyTwo) ?? .black).cgColor
        cLastNameTextField.layer.cornerRadius = 4
        cLastNameTextField.layer.borderWidth = 1
        cLastNameTextField.layer.borderColor = (UIColor(named: C.Colors.brownishGreyTwo) ?? .black).cgColor
        
        cLastNameLabel.text = C.LocKeys.sULastNameCellLbl.localized()
        cNameLabel.text = C.LocKeys.sUFirstNameCellLbl.localized()
        cNameTextField.placeholder = C.LocKeys.sUNamePlaceholder.localized()
        cLastNameTextField.placeholder = C.LocKeys.sULastNamePlaceholder.localized()
    }
    
    private func areHidden(_ view: UIView..., on: Bool) {
        view.forEach { $0.isHidden = on }
    }
    
    private func setupStyle() {
        switch style {
        case .name:
            cNameErrorLabel.text = C.LocKeys.sUNameErrorLbl.localized()
            cLastNameErrorLabel.text = C.LocKeys.sULastNameErrorLbl.localized()
            cNameTextField.autocapitalizationType = .words
            cLastNameTextField.autocapitalizationType = .words
            areHidden(cNameLabel, cNameTextField,
                      cLastNameLabel, cLastNameTextField,
                      on: false)
            areHidden(termsCheck, adsCheck, acceptTermsButton, recieveAdsLabel,
                      privacyPolicyButton, termsLabel, termsAndConditionsButton, on: true)
        case .termsCheck:
            areHidden(privacyPolicyButton, termsLabel, termsAndConditionsButton, on: true)
        case .privacyAndTerms:
            areHidden(termsCheck, adsCheck, acceptTermsButton, recieveAdsLabel, on: true)
        }
        
    }
}
