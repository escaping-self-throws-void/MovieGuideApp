//
//  SideMenuTableViewCell.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 18/07/2022.
//

import UIKit

final class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sideMenuImageView: MBCImageView!
    @IBOutlet weak var sideMenuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}
