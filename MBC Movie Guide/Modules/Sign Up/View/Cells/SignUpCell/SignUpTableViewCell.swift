//
//  SignUpTableViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import UIKit

enum SUCellStyle {
    case signUp
    case logIn
}

final class SignUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bigSignUpButton: UIButton!
    
    var style: SUCellStyle = .logIn
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setupStyle()
    }
     
    private func setupUI() {
        backgroundColor = .clear
        bigSignUpButton.isEnabled = false
        bigSignUpButton.alpha = 0.5
    }
    
    private func setupStyle() {
        switch style {
        case .signUp:
            bigSignUpButton.setTitle(C.LocKeys.sUBigButtonLbl.localized(), for: .normal)
        case .logIn:
            bigSignUpButton.setTitle(C.LocKeys.sUBigButtonLogInLbl.localized(), for: .normal)
        }
    }
}
