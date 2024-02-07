//
//  HomeRepository.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchMovies(
        searchText title: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    )
}

final class HomeRepository: HomeRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMovies(
        searchText title: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        let endpoint = Endpoint.searchMovie(searchText: title)
        return networkManager.request(endpoint, completion: completion)
    }
}
