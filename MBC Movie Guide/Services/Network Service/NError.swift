//
//  NError.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation

enum NError: Error {
    case invalidURL
    case invalidData
    case invalidStatusCode(Int)
    case unableToComplete
    case invalidResponse
    case unableToDecode
}
