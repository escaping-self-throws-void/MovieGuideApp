//
//  File.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 15/07/2022.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
            return String(describing: Self.self)
        }
}
