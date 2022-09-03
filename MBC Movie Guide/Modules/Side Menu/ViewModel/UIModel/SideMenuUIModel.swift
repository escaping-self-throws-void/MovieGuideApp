//
//  SideMenuUIModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 19/07/2022.
//

import UIKit


struct SideMenu {
    
    let section: [Section]
    
    struct Section {
        let rows: [Row]
    }

    struct Row {
        let type: SectionType
        let rowType: RowType
                
        var labelTextFont: UIFont? {
            switch type {
            case .userInfo:
                return UIFont(name: C.Fonts.almaraiExtraBold, size: 19)
            case .settings:
                return UIFont(name: C.Fonts.almaraiRegular, size: 16)
            }
        }
        
        var iconImage: UIImage? {
            switch rowType {
            case .account:
                return UIImage(named: C.Images.userIcon)
            case .timeline:
                return UIImage(named: C.Images.timelineIcon)
            case .genres:
                return UIImage(named: C.Images.genreIcon)
            case .watchlist:
                return UIImage(named: C.Images.watchlistIcon)
            case .quiz:
                return UIImage(named: C.Images.quizIcon)
            case .settings:
                return UIImage(named: C.Images.settingsIcon)
            case .logout:
                return UIImage(named: C.Images.logoutIcon)
            }
        }
        
        var title: String {
            switch rowType {
            case .account:
                return C.LocKeys.sideMenuAccount.localized()
            case .timeline:
                return C.LocKeys.timelineBarTitleLbl.localized()
            case .genres:
                return C.LocKeys.sideMenuGenres.localized()
            case .watchlist:
                return C.LocKeys.sideMenuWatchlist.localized()
            case .quiz:
                return C.LocKeys.sideMenuQuiz.localized()
            case .settings:
                return C.LocKeys.settingsTitle.localized()
            case .logout:
                return UserSession.shared.isGuest
                ? C.LocKeys.sideMenuLogin.localized() : C.LocKeys.sideMenuLogout.localized()
            }
        }
        
        enum SectionType {
            case userInfo
            case settings
        }
        
        enum RowType {
            case account
            case timeline
            case genres
            case watchlist
            case quiz
            case settings
            case logout
        }
    }

}

