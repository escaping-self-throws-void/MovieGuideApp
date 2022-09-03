//
//  CastCollectionViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 21/07/2022.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actorImageView: MBCImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setup(with row: MovieDetailsUIModel.Row) {
        let placeholder = UIImage(named: C.Images.actorPlaceholder)
        actorImageView.setImage(with: row.image, placeholder: placeholder)
        actorNameLabel.text = row.text
        actorNameLabel.font = row.font
    }
    
    private func setupUI() {
        actorImageView.layer.cornerRadius = 8
        actorImageView.contentMode = .scaleAspectFit

//        actorNameLabel.font = UIFont(name: C.Fonts.heeboRegular, size: 11)
        actorNameLabel.textColor = UIColor(named: C.Colors.veryLightPinkThree)
        actorNameLabel.textAlignment = .center
    }

}
