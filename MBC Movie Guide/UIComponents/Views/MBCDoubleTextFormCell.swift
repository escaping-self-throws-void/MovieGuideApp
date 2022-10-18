//
//  MBCDoubleTextFormCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 18/10/2022.
//

import UIKit

final class MBCDoubleTextFormCell: UITableViewCell {
    
    lazy var leftTextField = MBCTextField()
    lazy var rightTextField = MBCTextField()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        selectionStyle = .none
        rightTextField.place(on: contentView)
        leftTextField.place(on: contentView).pin(
            .leading(to: contentView, padding: 23),
            .centerY(),
            .fixedHeight(41),
            .width(to: rightTextField)
        )
        rightTextField.pin(
            .trailing(to: contentView, padding: 23),
            .centerY(),
            .fixedHeight(41),
            .fixedWidth(contentView.frame.width * 0.4)
        )
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MBCDoubleTextFormCell.reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension MBCDoubleTextFormCell {
    func configure(left: FormType, right: FormType) {
        leftTextField.configure(with: left)
        rightTextField.configure(with: right)
    }
}
