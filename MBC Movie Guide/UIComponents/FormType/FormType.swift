//
//  FormType.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 16/10/2022.
//

import UIKit

enum FormType {
    case name
    case lastName
    case email
    case password
    case confirm
    case birthday
    case gender
    case country
    case loginPassword
    
    var placeholder: String {
        switch self {
        case .name:
            return C.LocKeys.sUNamePlaceholder.localized()
        case .lastName:
            return C.LocKeys.sULastNamePlaceholder.localized()
        case .email:
            return C.LocKeys.sUEmailPlaceholder.localized()
        case .password, .loginPassword:
            return C.LocKeys.sUPasswordPlaceholder.localized()
        case .confirm:
            return C.LocKeys.sUConfirmPlaceholder.localized()
        case .birthday:
            return C.LocKeys.sUBirthdayPlaceholder.localized()
        case .gender:
            return C.LocKeys.sUGenderPlaceholder.localized()
        case .country:
            return C.LocKeys.sUCountryPlaceholder.localized()
        }
    }
    
    var regex: RegexType? {
        switch self {
        case .name:
            return .name
        case .lastName:
            return .lastName
        case .email:
            return .email
        case .password, .loginPassword:
            return .password
        case .confirm:
            return .confirm
        default:
            return nil
        }
    }
    
    var accessoryButton: UIView? {
        switch self {
        case .password, .confirm:
            return createPasswordButton()
//        case .birthday:
//            <#code#>
//        case .gender:
//            <#code#>
//        case .country:
//            <#code#>
        case .loginPassword:
            return createLoginPasswordButton()
        default:
            return nil
        }
    }
    
    
}

private extension FormType {
    private func createLoginPasswordButton() -> UIButton? {
        let button = UIButton(type: .custom)
        button.setTitle(C.LocKeys.sUForgotButton.localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: C.Fonts.almaraiBold, size: 13)
        return button
    }
    
    private func createPasswordButton() -> UIButton? {
        let button = UIButton(type: .custom)
        button.setImage(button.isEnabled
                        ? UIImage(named: C.Images.eyeClosed)
                        : UIImage(named: C.Images.eyeOpened ),
                        for: .normal)
        return button
    }
}
