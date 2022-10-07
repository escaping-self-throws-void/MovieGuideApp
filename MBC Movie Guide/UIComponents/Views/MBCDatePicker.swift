//
//  MBCDatePicker.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/10/2022.
//

import UIKit

final class MBCDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        datePickerMode = .date
        preferredDatePickerStyle = .wheels
        minimumDate = Calendar.current.date(byAdding: .year, value: -118, to: Date())
        maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
