//
//  MovieDetail.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import Foundation

struct MovieDetail: BaseResponse, Decodable {
    
    let title: String?
    let director: String?
    let actors: String?
    let genre: String?
    let duration: String?
    let imdbRating: String?
    let year: String?
    let plot: String?
    let imageUrl: String?
    var error: String?
    var response: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case director = "Director"
        case actors = "Actors"
        case genre = "Genre"
        case duration = "Runtime"
        case imdbRating
        case year = "year"
        case plot = "Plot"
        case imageUrl = "Poster"
        case error = "Error"
        case response = "Response"
    }
}
