//
//  SettingsUIModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 23/07/2022.
//

import UIKit

struct SettingsUIModel {
    
    let rows: [Row]
    
    struct Row {
        let type: RowType
        
        var title: String {
            switch type {
            case .language:
                return C.LocKeys.languageRowTitle.localized()
            case .notification:
                return C.LocKeys.notificationsRowTitle.localized()
            case .timeFormat:
                return C.LocKeys.timeFormatRowTitle.localized()
            case .privacy:
                return C.LocKeys.privacyRowTitle.localized()
            }
        }
        
        var iconImage: UIImage? {
            switch type {
            case .language:
                return UIImage(named: C.Images.languageIcon)
            case .notification:
                return UIImage(named: C.Images.notificationIcon)
            case .timeFormat:
                return UIImage(named: C.Images.timeFormatIcon)
            case .privacy:
                return UIImage(named: C.Images.privacyIcon)
            }
        }
    }
    
    enum RowType {
        case language
        case notification
        case timeFormat
        case privacy
    }
}
