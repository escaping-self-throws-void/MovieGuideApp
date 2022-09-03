//
//  MovieDetailsUIModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import UIKit

struct MovieDetailsUIModel {
    
    let sections: [Section]
    let header: Header
    
    struct Header {
        var poster: URL?
        let channel: String
        let titleEn: String
        let titleAr: String
        let date: String
        let duration: String
        var movieRelease: String?
        var isMbcTwo: Bool {
            channel == "10"
        }
    }
    
    struct Section {
        let type: SectionType
        let rows: [Row]
        var title: String? {
            switch type {
            case .synopsis:
                return nil
            case .cast:
                return C.LocKeys.castSectionTitle.localized()
            case .genres:
                return C.LocKeys.genresSectionTitle.localized()
            case .directors:
                return C.LocKeys.directorsSectionTitle.localized()
            }
        }
    }
    
    struct Row {
        let text: String
        var textAr: String?
        var image: URL?
        let type: RowType
        
        var font: UIFont? {
            switch type {
            case .cast:
                return UIFont(name: C.Fonts.heeboRegular, size: 11)
            case .genres:
                return UIFont(name: C.Fonts.almaraiRegular, size: 13.7)
            default:
                return UIFont(name: C.Fonts.almaraiRegular, size: 15)
            }
        }
    }
    
    enum SectionType {
        case synopsis
        case cast
        case directors
        case genres
        
    }
    
    enum RowType {
        case synopsis
        case cast
        case directors
        case genres
    }
}

struct MovieToShare {
    let image: UIImage?
    let title: String?
    let time: String
}
