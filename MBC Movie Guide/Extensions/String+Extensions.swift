//
//  String + Extensions.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 12/07/2022.
//

import Foundation

enum RegexType: String {
    case name, lastName = "^^[a-zA-Z]+[\\-\\'\\s]?[a-zA-Z ]{1,40}$"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //    Length 8 to 16.
    //    One Alphabet in Password.
    //    One Special Character in Password.
    case password, confirm = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,16}"
    
    var errorMessage: String? {
        switch self {
        case .name:
            return C.LocKeys.sUNameErrorLbl.localized()
        case .lastName:
            return C.LocKeys.sULastNameErrorLbl.localized()
        case .email:
            return C.LocKeys.sUEmailErrorLbl.localized()
        case .password:
            return C.LocKeys.sUPasswordErrorLb.localized()
        case .confirm:
            return C.LocKeys.sUConfirmErrorLbl.localized()
        }
    }
}

extension String {
    func validate(by type: RegexType) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", type.rawValue)
            .evaluate(with: self.trimmingCharacters(in: .whitespaces))
    }
    
    var getDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: self)
        return date ?? Date()
    }
}

