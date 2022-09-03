//
//  TimelineMovieCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 14/07/2022.
//

import UIKit

final class TimelineMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var movieImageView: MBCImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setup(with movie: MovieItem) {
        
        let mbcTwoPlaceholder = UIImage(named: C.Images.mbcTwoPlaceholder)
        let mbcMaxPlaceholder = UIImage(named: C.Images.mbcMaxPlaceholder)
        movieImageView.setImage(with: movie.poster,
                                placeholder: movie.isMbcTwo
                                ? mbcTwoPlaceholder : mbcMaxPlaceholder)
        
        titleLabel.text = LanguageService.shared.isEn ? movie.titleEn : movie.titleAr
        
        let movieDate = movie.date.getDate
        let timeString = movieDate.timeText
        
        timeLabel.text = movieDate.isAvailableNow ? C.LocKeys.nowTimeStampLbl.localized() : timeString
        
        let mbcTwoColor = UIColor(named: C.Colors.dullOrange)
        let mbcMaxColor = UIColor(named: C.Colors.midBlue)
        
        timeLabel.backgroundColor = movie.isMbcTwo ? mbcMaxColor : mbcTwoColor
        
    }
    
    private func setupUI() {
        titleLabel.font = UIFont(name: C.Fonts.almaraiRegular, size: 12)
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = .byTruncatingTail
        
        timeLabel.layer.cornerRadius = 9.9
        timeLabel.clipsToBounds = true
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: C.Fonts.almaraiBold, size: 11.7)
        timeLabel.allowsDefaultTighteningForTruncation = true
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 10
        movieImageView.layoutIfNeeded()
        
        backgroundColor = .clear
    }
    
}
