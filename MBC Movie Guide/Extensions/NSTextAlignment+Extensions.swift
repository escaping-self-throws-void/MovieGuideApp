//
//  NSTextAlignment+Extensions.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 24/07/2022.
//

import UIKit

extension NSTextAlignment {
    static var defaultAlignment: NSTextAlignment {
        return LanguageService.shared.isEn ? .left : .right
    }
}
