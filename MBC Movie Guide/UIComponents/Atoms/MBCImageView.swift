//
//  MBCImageView.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 18/07/2022.
//

import UIKit
import SDWebImage

final class MBCImageView: UIImageView {

    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        libSetImage(with: url, placeholder: placeholder)
    }
    
    private func libSetImage(with url: URL?, placeholder: UIImage? = nil) {
        // Adjustment for mock data
        let mockImage = UIImage(named: url?.absoluteString ?? "")
        image = mockImage ?? placeholder
//        sd_setImage(with: url, placeholderImage: placeholder)
    }
    
}
