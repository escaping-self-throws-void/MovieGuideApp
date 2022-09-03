//
//  SectionHeaderReusableView.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 15/07/2022.
//

import UIKit

final class SectionHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLogoImageView: UIImageView!
    
    func setup(with movie: MovieItem) {
        let mbcTwoLogoImage = UIImage(named: C.Images.mbcTwoLogo)
        let mbcMaxLogoImage = UIImage(named: C.Images.mbcMaxLogo)
        headerLogoImageView.contentMode = .scaleAspectFit
        headerLogoImageView.image = movie.isMbcTwo
            ? mbcTwoLogoImage : mbcMaxLogoImage
    }
}
