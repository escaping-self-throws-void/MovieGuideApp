//
//  Optional+Extensions.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit

extension Optional where Wrapped == String {
    
    var isEmptyOrNil: Bool {
        switch self {
        case .some(let value):
            return value.isEmpty
        default:
            return true
        }
    }
}

extension Optional where Wrapped == UIColor {
    var unwrap: UIColor {
        switch self {
        case .none:
            return .black
        case .some(let wrapped):
            return wrapped
        }
    }
}
