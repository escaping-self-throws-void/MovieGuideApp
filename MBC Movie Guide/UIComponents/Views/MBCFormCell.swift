//
//  MBCFormCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit
import RxSwift

final class MBCFormCell: UITableViewCell {
    
    lazy var textField: MBCTextField = {
        let tf = MBCTextField()
        return tf
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        selectionStyle = .none
        textField.place(on: contentView).pin(
            .leading(to: contentView, padding: 23),
            .trailing(to: contentView, padding: 23),
            .centerY(),
            .fixedHeight(41)
        )
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MBCFormCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(as type: FormType) {
        textField.configure(
            placeholder: type.placeholder,
            errorMessage: type.errorMessage
        )
    }
}
