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
    case loginEmail
    case loginPassword
    case login
    case privacyAndTerms
    case termsCheck
    case signUp
    
    var placeholder: String {
        switch self {
        case .name:
            return C.LocKeys.sUNamePlaceholder.localized()
        case .lastName:
            return C.LocKeys.sULastNamePlaceholder.localized()
        case .email, .loginEmail:
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
        default:
            return String()
        }
    }
    
    var regex: RegexType? {
        switch self {
        case .name:
            return .name
        case .lastName:
            return .lastName
        case .email, .loginEmail:
            return .email
        case .password, .loginPassword:
            return .password
        case .confirm:
            return .confirm
        default:
            return nil
        }
    }
    
    var keyboard: UIKeyboardType {
        switch self {
        case .name, .lastName:
            return .namePhonePad
        case .email, .loginEmail:
            return .emailAddress
        case .password, .confirm:
            return .twitter
        default:
            return .default
        }
    }
    
    var keyboardContent: UITextContentType? {
        switch self {
        case .name:
            return .name
        case .lastName:
            return .familyName
        case .email, .loginEmail:
            return .emailAddress
        case .password, .confirm, .loginPassword:
            return .password
        default:
            return nil
        }
    }
    
    var isSecure: Bool {
        switch self {
        case .password, .loginPassword, .confirm:
            return true
        default:
            return false
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
        button.setImage(UIImage(named: C.Images.eyeClosed),
                        for: .normal)
        return button
    }
}
