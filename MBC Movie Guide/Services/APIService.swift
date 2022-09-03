//
//  APIService.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

protocol APIService {
    func fetchMovies(on date: String, completion: @escaping (Result<[MovieData], NError>) -> Void)
    func fetchDetail(for id: String, completion: @escaping (Result<MovieDetail, NError>) -> Void)
}

final class APIFetcher: APIService, NetworkService {
    typealias MovieDataResult = (Result<[MovieData], NError>) -> Void
    typealias MovieDetailResult = (Result<MovieDetail, NError>) -> Void
    
    func fetchMovies(on date: String, completion: @escaping MovieDataResult) {
        let stringUrl = C.Links.movieDataApi + date
        fetch(from: stringUrl, completion: completion)
    }
    
    func fetchDetail(for id: String, completion: @escaping MovieDetailResult) {
        let stringUrl = C.Links.movieDetailApi + id
        fetch(from: stringUrl, completion: completion)
    }
}
