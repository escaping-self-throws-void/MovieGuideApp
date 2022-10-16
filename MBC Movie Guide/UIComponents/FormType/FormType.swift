//
//  FormType.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 16/10/2022.
//

import Foundation

enum FormType {
    case email
    case password
    case confirm
    case birthday
    case gender
    case country
    
    var placeholder: String {
        switch self {
        case .email:
            return C.LocKeys.sUEmailPlaceholder.localized()
        case .password:
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
    
    var errorMessage: String? {
        switch self {
        case .email:
            return C.LocKeys.sUEmailErrorLbl.localized()
        case .password:
            return C.LocKeys.sUPasswordErrorLb.localized()
        case .confirm:
            return C.LocKeys.sUConfirmErrorLbl.localized()
        default:
            return nil
        }
    }
    
    var regex: RegexType? {
        switch self {
        case .email:
            return .email
        case .password:
            return .password
        case .confirm:
            return .password
        default:
            return nil
        }
    }
    
    
}
