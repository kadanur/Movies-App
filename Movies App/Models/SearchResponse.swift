//
//  SearchResponse.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

struct SearchResponse: BaseResponse, Decodable {
    let results: [SearchResult]?
    var error: String?
    var response: String?
    
    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case error = "Error"
        case response = "Response"
    }
}

struct SearchResult: Decodable {
    let title: String?
    let year: String?
    let imdbId: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case image = "Poster"
    }
}
