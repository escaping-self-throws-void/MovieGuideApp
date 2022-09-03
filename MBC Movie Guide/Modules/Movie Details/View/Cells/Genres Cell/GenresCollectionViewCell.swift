//
//  GenresCollectionViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 21/07/2022.
//

import UIKit

final class GenresCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGenresUI()
    }
    
    func setup(with row: MovieDetailsUIModel.Row) {
        genresLabel.text = row.text
        genresLabel.font = row.font
    }
    
    private func setupGenresUI() {
        genresLabel.layer.cornerRadius = 4.9
        genresLabel.layer.borderWidth = 0.5
        genresLabel.layer.borderColor = UIColor(named: C.Colors.veryLightPinkThree)?.cgColor
        genresLabel.textAlignment = .center
    }

}
