//
//  MBCFormCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit

final class MBCFormCell: UITableViewCell {
    
    let textField: MBCTextField = {
        let tf = MBCTextField("Email")
        return tf
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
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
}
