//
//  HomeCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc: HomeVC = .instantiate()
        vc.coordinator = self
        vc.viewModel = HomeVM(repository: HomeRepository())
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieDetail(imdbId: String?) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        addChild(coordinator: coordinator)
        coordinator.start(imdbId: imdbId)
    }
}
