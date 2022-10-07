//
//  MBCTextField.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit

final class MBCTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        layoutMargins.left = 5
        textAlignment = .defaultAlignment
        font = .init(name: C.Fonts.almaraiRegular, size: 15)
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: C.Colors.brownishGreyTwo).unwrap.cgColor
    }
}

