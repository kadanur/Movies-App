//
//  MovieDetailRepository.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import Foundation

protocol MovieDetailRepositoryProtocol {
    func fetchMovieDetail(
        imdbId: String,
        completion: @escaping (Result<MovieDetail, Error>) -> Void
    )
}

final class MovieDetailRepository: MovieDetailRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMovieDetail(
        imdbId: String,
        completion: @escaping (Result<MovieDetail, Error>) -> Void
    ) {
        let endpoint = Endpoint.getMovie(imdbId: imdbId)
        return networkManager.request(endpoint, completion: completion)
    }
}
