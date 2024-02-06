//
//  MovieDetailVM.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import Foundation

final class MovieDetailVM: MovieDetailVMProtocol {
    
    private let imdbId: String?
    private let repository: MovieDetailRepositoryProtocol
    
    weak var delegate: MovieDetailVMDelegate?
    
    init(imdbId: String?, repository: MovieDetailRepositoryProtocol) {
        self.imdbId = imdbId
        self.repository = repository
    }
    
    func handleVMInput(_ input: MovieDetailVMInput) {
        switch input {
        case .load:
            fetchMovieDetail()
        }
    }
}

private extension MovieDetailVM {
    
    func fetchMovieDetail() {
        guard let imdbId else { return }
        
        showLoading(true)
        repository.fetchMovieDetail(imdbId: imdbId) { [weak self] result in
            guard let self else { return }
            
            showLoading(false)
            
            switch result {
            case let .success(response):
                if let error = response.error {
                    delegate?.handleVMOutput(.presentError(message: error))
                } else {
                    delegate?.handleVMOutput(.updateMovieDetail(response))
                }
            case let .failure(error):
                delegate?.handleVMOutput(.presentError(message: error.localizedDescription))
            }
        }
    }
    
    func showLoading(_ state: Bool) {
        delegate?.handleVMOutput(.showLoading(state))
    }
}
