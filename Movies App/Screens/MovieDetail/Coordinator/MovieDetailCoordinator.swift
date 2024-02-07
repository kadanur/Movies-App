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
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(imdbId: String?) {
        let vc: MovieDetailVC = .instantiate()
        let repository = MovieDetailRepository(networkManager: NetworkManager())
        let viewModel = MovieDetailVM(imdbId: imdbId, repository: repository)
        
        vc.coordinator = self
        vc.viewModel = viewModel
        rootViewController = vc
        
        navigationController.pushViewController(vc, animated: true)
    }
}
