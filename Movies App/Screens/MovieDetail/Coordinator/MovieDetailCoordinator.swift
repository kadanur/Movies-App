//
//  MovieDetailCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(imdbId: String?) {
        let vc: MovieDetailVC = .instantiate()
        vc.coordinator = self
        vc.viewModel = MovieDetailVM(imdbId: imdbId, repository: MovieDetailRepository())
        
        navigationController.pushViewController(vc, animated: true)
    }
}
