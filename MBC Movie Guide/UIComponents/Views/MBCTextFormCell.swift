//
//  MBCFormCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit
import CountryPickerView

final class MBCTextFormCell: UITableViewCell {
    
    lazy var textField = MBCTextField()
    lazy var cpv = CountryPickerView()

    private lazy var genders = [C.Genders.none, C.Genders.male, C.Genders.female]
    
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
        super.init(style: style, reuseIdentifier: MBCTextFormCell.reuseIdentifier)
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

extension MBCTextFormCell {
    func configure(as type: FormType) {
        textField.configure(with: type)
        setupInputViews(type)
    }
    
    private func setupInputViews(_ type: FormType) {
        switch type {
        case .birthday:
            let datePicker = MBCDatePicker()
            datePicker.addTarget(self, action: #selector(dateChange(_:)), for: UIControl.Event.valueChanged)
            
            textField.inputView = datePicker
            textField.delegate = self
        case .gender:
            let genderPicker = UIPickerView()
            genderPicker.delegate = self
            genderPicker.dataSource = self
            
            textField.inputView = genderPicker
            textField.delegate = self
        case .country:
            cpv.delegate = self
            textField.delegate = self
        default: break
        }
    }
}

// MARK: - Input views methods

extension MBCTextFormCell: UITextFieldDelegate {
    @objc private func dateChange(_ datePicker: UIDatePicker) {
        textField.text = datePicker.date.birthdayText
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        resignFirstResponder()
        return false
    }
}

// MARK: - UIPickerView Delegate and DataSource methods

extension MBCTextFormCell: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row != 0 else {
            textField.text = ""
            return
        }
        textField.text = genders[row]
    }

}

// MARK: - CountryPickerViewDelegate methods

extension MBCTextFormCell: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        textField.text = country.name
    }
}
