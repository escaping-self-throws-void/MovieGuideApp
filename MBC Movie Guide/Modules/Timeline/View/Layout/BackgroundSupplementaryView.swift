//
//  File.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 15/07/2022.
//

import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    
    static let kind = "background"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 13
        layer.borderWidth = 1.2
        backgroundColor = UIColor(named: C.Colors.nightBlue)
    }
    
    func setup(with movie: MovieItem) {
        let mbcTwoColor = UIColor(named: C.Colors.cobalt)?.cgColor
        let mbcMaxColor = UIColor(named: C.Colors.dullOrange)?.cgColor
        layer.borderColor = movie.isMbcTwo ? mbcTwoColor : mbcMaxColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
