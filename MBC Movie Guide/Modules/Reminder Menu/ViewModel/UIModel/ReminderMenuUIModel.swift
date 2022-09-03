//
//  ReminderMenuUIModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 22/07/2022.
//

import UIKit

struct ReminderMenuUIModel {
    
    let rows: [Row]
  
    struct Row {
        var type: RowType
        var rowIcon: UIImage? {
            switch type {
            case .watch:
                return UIImage(named: C.Images.watchNowIcon)
            case .reminder:
                return UIImage(named: C.Images.addReminder)
            case .share:
                return UIImage(named: C.Images.shareIcon)
            }
        }
        var title: String? {
            switch type {
            case .watch:
                return C.LocKeys.reminderMenuWatchNow.localized()
            case .reminder:
                return C.LocKeys.reminderMenuSetReminder.localized()
            case .share:
                return C.LocKeys.reminderMenuShareMovie.localized()
            }
        }
        var font: UIFont? {
            return UIFont(name: C.Fonts.almaraiRegular, size: 16)
        }
    }
    
    enum RowType {
        case watch
        case reminder
        case share
    }
}
