//
//  PopUpTableViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 16/07/2022.
//

import UIKit

final class PopUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedUI(selected)
    }
    
    func setup(with date: Date) {
        dayLabel.text = date.popUpDayText
        monthLabel.text = date.popUpMonthText
    }
    
    private func selectedUI(_ selected: Bool) {
        monthLabel.textColor = selected ? UIColor(named: C.Colors.darkSkyBlue) : .white
        monthLabel.font = UIFont(name: selected ? C.Fonts.almaraiBold : C.Fonts.almaraiRegular, size: 16)
        
        containerView.backgroundColor = selected ? UIColor(named: C.Colors.lightPeriwinkle) : .clear
        containerView.layer.cornerRadius = selected ? 6 : 0
        containerView.layer.borderWidth = selected ? 1 : 0
        containerView.layer.borderColor = UIColor(named: C.Colors.darkSkyBlue)?.cgColor
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        dayLabel.font = UIFont(name: C.Fonts.almaraiBold, size: 22)
        dayLabel.textColor = UIColor(named: C.Colors.darkSkyBlue)
    }
    
}
