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
    
    private let disposeBag = DisposeBag()
    
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

// MARK: - Configuration

extension MBCFormCell {
    func configure(as type: FormType) {
        textField.configure(
            placeholder: type.placeholder
        )

        textField.addAccessoryView(type.accessoryButton)
        textField.rx.text
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] text in
                guard let self else { return }
                self.textField.validate(text: text, as: type.regex)
            }).disposed(by: disposeBag)
        
    }
    
}
