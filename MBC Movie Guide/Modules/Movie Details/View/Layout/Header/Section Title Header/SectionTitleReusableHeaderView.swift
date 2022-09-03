//
//  SectionTitleReusableHeaderView.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 21/07/2022.
//

import UIKit

final class SectionTitleReusableHeaderView: UICollectionReusableView {

    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionTitleLabel.font = UIFont(name: C.Fonts.almaraiBold, size: 15)
        sectionTitleLabel.textColor = .white
    }
    
    func setup(title: String) {
        sectionTitleLabel.text = title
    }
    
}
