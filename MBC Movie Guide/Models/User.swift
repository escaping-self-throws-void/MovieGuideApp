//
//  User.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 12/07/2022.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let birthday: String
    let gender: String
    let country: String
    let adsAccepted: Bool
}

extension User {
    var fullName: String? {
        firstName + " " + lastName
    }
}
