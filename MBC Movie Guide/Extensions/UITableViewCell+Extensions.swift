//
//  UITableViewCell+Extensions.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 18/10/2022.
//

import UIKit

extension UITableViewCell {
    func removeSubviews() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
