//
//  SynopsisCollectionViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 21/07/2022.
//

import UIKit

final class SynopsisCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var synopsisTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setup(with row: MovieDetailsUIModel.Row) {
        synopsisTextView.text = LanguageService.shared.isEn ? row.text : row.textAr
        synopsisTextView.font = row.font
    }
    
    private func setupUI() {
        backgroundColor = .clear
//        synopsisTextView.font = UIFont(name: C.Fonts.almaraiRegular, size: 15)
        synopsisTextView.textColor = UIColor(named: C.Colors.veryLightPinkThree)
        synopsisTextView.backgroundColor = .clear
        synopsisTextView.isEditable = false
    }

}
