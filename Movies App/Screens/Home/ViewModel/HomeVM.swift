//
//  HomeVM.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

final class HomeVM: HomeVMProtocol {
    
    private let repository: HomeRepositoryProtocol
    
    weak var delegate: HomeVMDelegate?
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func handleVMInput(_ input: HomeVMInput) {
        switch input {
        case let .searchBarTextDidChange(searchText):
            fetchMovies(searchText: searchText)
        }
    }
}

private extension HomeVM {
    
    func fetchMovies(searchText: String) {
        guard searchText.count >= 2, !searchText.isEmpty else { return }
        
        showLoading(true)
        repository.fetchMovies(searchText: searchText) { [weak self] result in
            guard let self else { return }
            
            self.showLoading(false)
            
            switch result {
            case let .success(response):
                guard let movies = response.results else {
                    let message = response.error ?? "Process failed, Please try again."

                    delegate?.handleVMOutput(.updateState(.info(info: message)))
                    return
                }
                
                let state: HomeState = movies.count == 0 ? .info(info: "Movie not found") : .list(movies: movies)
                delegate?.handleVMOutput(.updateState(state))
            case let .failure(error):
                delegate?.handleVMOutput(.updateState(.info(info: error.localizedDescription)))
            }
        }
    }
    
    func showLoading(_ state: Bool) {
        delegate?.handleVMOutput(.showLoading(state))
    }
}
