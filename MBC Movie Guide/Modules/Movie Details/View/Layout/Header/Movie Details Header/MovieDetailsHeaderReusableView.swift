//
//  MovieDetailsHeaderReusableView.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import UIKit

final class MovieDetailsHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var posterImageView: MBCImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var reminderButtom: UIButton!
    @IBOutlet weak var watchlistButton: UIButton!
    @IBOutlet weak var chatroomButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setup(with details: MovieDetailsUIModel.Header) {        
        let mbcTwoColor = UIColor(named: C.Colors.cobalt)?.cgColor
        let mbcMaxColor = UIColor(named: C.Colors.dullOrange)?.cgColor
        
        let mbcTwoPlaceholder = UIImage(named: C.Images.mbcTwoPlaceholder)
        let mbcMaxPlaceholder = UIImage(named: C.Images.mbcMaxPlaceholder)
        posterImageView.setImage(with: details.poster,
                                 placeholder: details.isMbcTwo ? mbcTwoPlaceholder : mbcMaxPlaceholder)
        posterImageView.layer.borderColor = details.isMbcTwo ? mbcTwoColor : mbcMaxColor
        
        let mbcMaxLogoImage = UIImage(named: C.Images.mbcMaxLogo)
        let mbcTwoLogoImage = UIImage(named: C.Images.mbcTwoLogo)
        logoImageView.image = details.isMbcTwo ? mbcTwoLogoImage : mbcMaxLogoImage
        
        movieTitleLabel.text = LanguageService.shared.isEn ? details.titleEn : details.titleAr
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: C.Fonts.almaraiBold, size: 13.5)]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: C.Fonts.almaraiRegular, size: 12.6)]
        
        let currentTime = details.date.getDate.timeText
        let movieDuration = "    |    \(details.duration)"
        let attributedString1 = NSMutableAttributedString(string: currentTime,
                                                          attributes: attrs1 as [NSAttributedString.Key : Any])

        let attributedString2 = NSMutableAttributedString(string: movieDuration,
                                                          attributes: attrs2 as [NSAttributedString.Key : Any])

        attributedString1.append(attributedString2)
        timeInfoLabel.attributedText = attributedString1
        
        let mbcTwoTimeColor = UIColor(named: C.Colors.dullOrange)
        let mbcMaxTimeColor = UIColor(named: C.Colors.midBlue)
        timeInfoLabel.backgroundColor = details.isMbcTwo ? mbcMaxTimeColor : mbcTwoTimeColor
        
        releaseDateLabel.text = details.movieRelease?.getDate.releaseLabelText ?? Date().releaseLabelText
    }
  
    private func setupUI() {
        backgroundColor = .clear

        // Background View setup
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 17
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.backgroundColor = UIColor(named: C.Colors.darkBlueGrey) ?? .black

        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = (UIColor(named: C.Colors.dark) ?? .black).cgColor
        
        // Poster Image View setup
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 9
        posterImageView.layer.borderWidth = 2.7
        
        // Logo Image View setup
        logoImageView.contentMode = .scaleAspectFit
        
        // Movie Title Label setup
        movieTitleLabel.font = UIFont(name: C.Fonts.almaraiBold, size: 21)
        movieTitleLabel.textAlignment = .center
        
        // Time Info Label setup
        timeInfoLabel.layer.cornerRadius = 9.9
        timeInfoLabel.clipsToBounds = true
        timeInfoLabel.textAlignment = .center
        
        // Release Date Label setup
        releaseDateLabel.font = UIFont(name: C.Fonts.almaraiRegular, size: 10)
        releaseDateLabel.textAlignment = .center
        
        // Watchlist and Chatroom Buttons setup
        watchlistButton.titleLabel?.tintColor = .black
        chatroomButton.titleLabel?.tintColor = .black
        
        watchlistButton.backgroundColor = .white
        chatroomButton.backgroundColor = .white
        
        watchlistButton.layer.cornerRadius = 4
        chatroomButton.layer.cornerRadius = 4
        
        let buttonFont = UIFont(name: C.Fonts.almaraiBold, size: 15)
        watchlistButton.titleLabel?.font = buttonFont
        chatroomButton.titleLabel?.font = buttonFont
        
        watchlistButton.setTitle(C.LocKeys.watchListButton.localized(), for: .normal)
        chatroomButton.setTitle(C.LocKeys.chatroomButton.localized(), for: .normal)
    }
    
}
