//
//  MovieItem.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

struct MovieItem: Decodable {
    let id: String
    let channel: String
    let movieRelease: String?
    let poster: URL?
    let movieId: String
    let active: Bool
    let date: String
    let duration: String
    let titleEn: String
    let titleAr: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case channel, date, movieId
        case duration, poster, active, titleEn, titleAr, movieRelease
    }
    
    var isMbcTwo: Bool {
        channel == "10"
    }
}
