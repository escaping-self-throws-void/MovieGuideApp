//
//  MovieDetail.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import Foundation

struct MovieDetail: Decodable {
    let id, channel, date, movieId, duration: String
    let poster: URL?
    let movieRelease, rated, imdb, youtube: String?
    let titleEn, titleAr, synopsisEn, synopsisAr: String
    let genres: [Genre]
    let actors, directors, writers: [Actor]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case channel, date, movieId
        case movieRelease, duration, rated, imdb, poster, titleEn, titleAr, synopsisEn, synopsisAr, genres, actors, directors, writers, youtube
    }
}

struct Actor: Decodable {
    let id, name: String
    let v: Int
    let image: URL?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case v = "__v"
        case image
    }
}

struct Genre: Decodable {
    let id, nameEn: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nameEn = "name_en"
        case v = "__v"
    }
}
