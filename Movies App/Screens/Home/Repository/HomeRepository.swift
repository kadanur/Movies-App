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
    
    func fetchMovies(
        searchText title: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        let endpoint = EndPoint.searchMovie(searchText: title)
        return networkManager.request(endpoint, completion: completion)
    }
}
