//
//  DirectorsCollectionViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 21/07/2022.
//

import UIKit

final class DirectorsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var directorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        directorsLabel.textColor = UIColor(named: C.Colors.veryLightPinkThree)
    }
    
    func setup(with row: MovieDetailsUIModel.Row) {
        directorsLabel.text = row.text
        directorsLabel.font = row.font
    }
}
