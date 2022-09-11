//
//  APIService.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

typealias MovieDataResult = (Result<[MovieData], NError>) -> Void
typealias MovieDetailResult = (Result<MovieDetail, NError>) -> Void

protocol APIService {
    func fetchMovies(on date: String, completion: @escaping MovieDataResult)
    func fetchDetail(for id: String, completion: @escaping MovieDetailResult)
}

final class APIFetcher: APIService, NetworkService {

    func fetchMovies(on date: String, completion: @escaping MovieDataResult) {
        let stringUrl = C.Links.movieDataApi + date
        fetch(from: stringUrl, completion: completion)
    }
    
    func fetchDetail(for id: String, completion: @escaping MovieDetailResult) {
        let stringUrl = C.Links.movieDetailApi + id
        fetch(from: stringUrl, completion: completion)
    }
}

final class MockFetcher: APIService {
    
    private var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func fetchMovies(on date: String, completion: @escaping MovieDataResult) {
        let filename = "timeline" + date.suffix(2)
        print(filename)
        loadJSON(filename: filename, completion: completion)
    }
    
    func fetchDetail(for id: String, completion: @escaping MovieDetailResult) {
        let filename = "movie" + id
        loadJSON(filename: filename, completion: completion)
    }
    
    private func loadJSON<T:Decodable>(filename: String, completion: @escaping (Result<T, NError>) -> Void) {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            print("FUCK")
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            
            completion(.success(decodedObject))
        } catch {
            completion(.failure(.unableToDecode))
        }
    }
    
}
