//
//  String + Extensions.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 12/07/2022.
//

import Foundation

enum RegexType: String {
    case name = "^^[a-zA-Z]+[\\-\\'\\s]?[a-zA-Z ]{1,40}$"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //    Length 8 to 16.
    //    One Alphabet in Password.
    //    One Special Character in Password.
    case password = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,16}"
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

