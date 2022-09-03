//
//  MovieData.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

struct MovieData: Decodable {
    let id: String
    let movies: [MovieItem]
   
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case movies
    }
}
