//
//  NetworkService.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(from url: String, completion: @escaping (Result<T, NError>) -> Void)
}

extension NetworkService {
    func fetch<T: Decodable>(from url: String, completion: @escaping (Result<T, NError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200..<300).contains(response.statusCode) else {
                completion(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
